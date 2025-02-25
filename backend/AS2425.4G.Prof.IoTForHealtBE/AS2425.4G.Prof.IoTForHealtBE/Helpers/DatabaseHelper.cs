
using System;
using System.Data;
using Microsoft.Extensions.Configuration;
using Npgsql;

namespace AS2425._4G.Prof.IoTForHealtBE.Helpers;

public class DatabaseHelper
{
    private readonly string _connectionString;

    public DatabaseHelper(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("PostgresDb");
    }

    public DataTable ExecuteQuery(string query, List<NpgsqlParameter>? parameters = null)
    {
        using (var conn = new NpgsqlConnection(_connectionString))
        {
            using (var cmd = new NpgsqlCommand(query, conn))
            {
                if (parameters != null && parameters.Count > 0)
                {
                    cmd.Parameters.AddRange(parameters.ToArray()); // Add parameters only if they exist
                }

                using (var adapter = new NpgsqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    adapter.Fill(dt);
                    return dt;
                }
            }
        }
    }

    public int ExecuteNonQuery(string query, List<NpgsqlParameter> parameters)
    {
        using (var connection = new NpgsqlConnection(_connectionString))
        {
            using (var command = new NpgsqlCommand(query, connection))
            {
                // Add parameters to command
                command.Parameters.AddRange(parameters.ToArray());

                // Open connection and execute the query
                connection.Open();
                return command.ExecuteNonQuery(); // Returns the number of affected rows
            }
        }
    }
}
