using AS2425._4G.Prof.IoTForHealtBE.Helpers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Npgsql;
using System.Data;
using System.Text.Json;


// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace AS2425._4G.Prof.IoTForHealtBE.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PatientsController : ControllerBase
    {
        private readonly DatabaseHelper _dbHelper;

        public PatientsController(IConfiguration configuration)
        {
            _dbHelper = new DatabaseHelper(configuration);
        }

        [HttpGet]
        [Authorize] // 🔒 This endpoint requires a valid JWT token
        public IActionResult GetPatients()
        {
            try
            {
                string query = @"
                    SELECT 
                        patient_id, name, surname, email, username, password
                    FROM 
                        patients";

                DataTable patientsTable = _dbHelper.ExecuteQuery(query);

                // method 1 with System.Text.Json
                //var patients = new List<Patient>();

                //foreach (DataRow row in patientsTable.Rows)
                //{
                //    patients.Add(new Patient
                //    {
                //        Patient_Id = Convert.ToInt32(row["patient_id"]),
                //        Name = row["name"].ToString(),
                //        Email = row["email"].ToString()
                //    });
                //}

                //return Ok(patients);

                // method 2 with Newtonsoft
                string jsonResult = Newtonsoft.Json.JsonConvert.SerializeObject(patientsTable);

                return Content(jsonResult, "application/json"); // Explicit JSON response
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Internal Server Error", error = ex.Message });
            }
        }

        // GET api/<PatientsController>/5
        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            try
            {
                string query = @"
                    SELECT 
                        patient_id, name, surname, email, username, password
                    FROM 
                        patients 
                    WHERE 
                        patient_id = @id";

                var parameters = new List<NpgsqlParameter>
                {
                    new NpgsqlParameter("@id", id)
                };

                DataTable patientsTable = _dbHelper.ExecuteQuery(query, parameters); // Pass parameters securely

                string jsonResult = Newtonsoft.Json.JsonConvert.SerializeObject(patientsTable);

                return Content(jsonResult, "application/json"); // Explicit JSON response
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Internal Server Error",
                    error = ex.Message
                });
            }
        }

        // GET api/<PatientsController>/search
        // GET with body (not recomended)
        [HttpGet("search")]
        public IActionResult SearchPatients([FromBody] JsonElement request)
        {
            try
            {
                string query = @"
                    SELECT 
                        patient_id, name, surname, email, username, password
                    FROM 
                        patients 
                    WHERE 
                        name = @name";

                var parameters = new List<NpgsqlParameter>
                {
                    new NpgsqlParameter("@name", request.GetProperty("name").GetString())
                };

                DataTable patientsTable = _dbHelper.ExecuteQuery(query, parameters); // Pass parameters securely

                string jsonResult = Newtonsoft.Json.JsonConvert.SerializeObject(patientsTable);

                return Content(jsonResult, "application/json"); // Explicit JSON response
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Internal Server Error",
                    error = ex.Message
                });
            }

        }

        // POST api/<PatientsController>
        [HttpPost]
        public IActionResult Post([FromBody] JsonElement request)
        {
            try
            {
                string query = @"
                    INSERT INTO 
                        patients (name, surname, email, username, password) 
                    VALUES 
                        (@name, @surname, @email, @username, @password)";

                var parameters = new List<NpgsqlParameter>
                {
                    new NpgsqlParameter("@name", request.GetProperty("name").GetString()),
                    new NpgsqlParameter("@surname", request.GetProperty("surname").GetString()),
                    new NpgsqlParameter("@email", request.GetProperty("email").GetString()),
                    new NpgsqlParameter("@username", request.GetProperty("username").GetString()),
                    new NpgsqlParameter("@password", request.GetProperty("password").GetString())
                };

                var rowsAffected = _dbHelper.ExecuteNonQuery(query, parameters);

                return Ok(new { message = "Patient added successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Internal Server Error", error = ex.Message });
            }

        }


        // PUT api/<PatientsController>/5
        [HttpPut("{id}")]
        public IActionResult Put(int id, [FromBody] JsonElement request)
        {
            try
            {
                string query = @"
                    UPDATE patients
                    SET 
                        name = @name, 
                        surname = @surname, 
                        email = @email, 
                        username = @username, 
                        password = @password
                    WHERE 
                        patient_id = @id";

                var parameters = new List<NpgsqlParameter>
                {
                    new NpgsqlParameter("@id", id),
                    new NpgsqlParameter("@name", request.GetProperty("name").GetString()),
                    new NpgsqlParameter("@surname", request.GetProperty("surname").GetString()),
                    new NpgsqlParameter("@email", request.GetProperty("email").GetString()),
                    new NpgsqlParameter("@username", request.GetProperty("username").GetString()),
                    new NpgsqlParameter("@password", request.GetProperty("password").GetString())
                };

                var rowsAffected = _dbHelper.ExecuteNonQuery(query, parameters);

                if (rowsAffected > 0)
                {
                    return Ok(new { message = $"Patient with ID {id} updated successfully" });
                }
                else
                {
                    return NotFound(new { message = $"Patient with ID {id} not found" });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Internal Server Error", error = ex.Message });
            }
        }

        // DELETE api/<PatientsController>/5
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                string query = @"
                    DELETE FROM 
                        patients 
                    WHERE 
                        patient_id = @id";

                var parameters = new List<NpgsqlParameter>
                {
                    new NpgsqlParameter("@id", id)
                };

                var rowsAffected = _dbHelper.ExecuteNonQuery(query, parameters);

                if (rowsAffected > 0)
                {
                    return Ok(new { message = $"Patient with ID {id} deleted successfully" });
                }
                else
                {
                    return NotFound(new { message = $"Patient with ID {id} not found" });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Internal Server Error",
                    error = ex.Message
                });
            }
        }
    }
}
