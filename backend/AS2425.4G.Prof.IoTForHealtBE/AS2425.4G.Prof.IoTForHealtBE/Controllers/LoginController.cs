using AS2425._4G.Prof.IoTForHealtBE.Helpers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Npgsql;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Text.Json;


namespace AS2425._4G.Prof.IoTForHealtBE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly DatabaseHelper _dbHelper;

        public LoginController(IConfiguration configuration)
        {
            _configuration = configuration;
            _dbHelper = new DatabaseHelper(configuration);
        }

        [HttpPost]
        public IActionResult GenerateToken([FromBody] JsonElement userLogin)
        {
            if (IsValidUser(userLogin))
            {
                var token = CreateJwtToken(userLogin.GetProperty("username").GetString());
                return Ok(new { token });
            }
            return Unauthorized(new { message = "Invalid credentials" });
        }

        /// <summary>
        /// check if the username of the PATIENT or CLINICIAN is valid
        /// </summary>
        /// <param name="userLogin"></param>
        /// <returns></returns>
        private bool IsValidUser(JsonElement userLogin)
        {
            try
            {
                string query;

                switch (userLogin.GetProperty("role").GetString())
                {
                    case "PATIENT":
                        query = @"
                            SELECT 
                                password
                            FROM 
                                patients 
                            WHERE 
                                username = @username";
                        break;
                    case "CLINICIAN":
                        query = @"
                            SELECT 
                                password
                            FROM 
                                clinicians 
                            WHERE 
                                username = @username";
                        break;
                    default:
                        return false;
                }

                var parameters = new List<NpgsqlParameter>
                {
                    new NpgsqlParameter("@username", userLogin.GetProperty("username").GetString())
                };

                DataTable dt = _dbHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count == 1 && 
                    userLogin.GetProperty("password").GetString() == dt.Rows[0]["password"].ToString())
                    return true;
                else
                    return false;
            }
            catch
            {
                return false;
            }
        }

        private string CreateJwtToken(string username)
        {
            var jwtSettings = _configuration.GetSection("Jwt");
            var key = Encoding.UTF8.GetBytes(jwtSettings["SecretKey"]);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, username),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim(ClaimTypes.Role, "User") // You can add roles here
            };

            var token = new JwtSecurityToken(
                issuer: jwtSettings["Issuer"],
                audience: jwtSettings["Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(Convert.ToDouble(jwtSettings["ExpireMinutes"])),
                signingCredentials: new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256)
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}
