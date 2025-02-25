## body test API

{
    "name": "name 1",
    "surname": "surname 1",
    "email": "johndoe@example.com",
    "username": "name.surname",
    "password": "password1"
}
{
    "name": "name 2",
    "surname": "surname 2",
    "email": "johndoe2@example.com",
    "username": "name.surname2",
    "password": "password2"
}

## body for request to test get with body (not recomended)
{
    "name": "name 1"
}

## body test API - to update
Id = 2
{
    "name": "name 22",
    "surname": "surname 22",
    "email": "johndoe22@example.com",
    "username": "name.surname22",
    "password": "password22"
}

# To improve backend
- password hashed
- authentication/authorization (JWT)
- entity framework instead of datatable

# To create a new user on neon
CREATE ROLE student_user WITH LOGIN PASSWORD 'secure_password';

Grant Permissions
## Read-only access (recommended for students):
GRANT CONNECT ON DATABASE your_database_name TO student_user;
GRANT USAGE ON SCHEMA public TO student_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO student_user;

## Read and write access (if students need to modify data):
GRANT CONNECT ON DATABASE your_database_name TO student_user;
GRANT USAGE ON SCHEMA public TO student_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO student_user;

### example

-- Step 1: Create a new role for students
CREATE ROLE student_user WITH LOGIN PASSWORD 'secure_password';

-- Step 2: Grant connect and usage permissions
GRANT CONNECT ON DATABASE my_database TO student_user;
GRANT USAGE ON SCHEMA public TO student_user;

-- Step 3: Grant read, write, and delete permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO student_user;

-- Step 4: Grant access to sequences (if needed)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO student_user;

-- Step 5: Test the new user
\c my_database student_user

-- Test read access
SELECT * FROM your_table;

-- Test write access
INSERT INTO your_table (column1, column2) VALUES ('value1', 'value2');

-- Test delete access
DELETE FROM your_table WHERE column1 = 'value1';

-- Verify schema alteration is not allowed (should fail)
CREATE TABLE test_table (id SERIAL PRIMARY KEY);

## command executed

CREATE ROLE student_user WITH LOGIN PASSWORD 'upgX7GhXrNMVjtmpmKXcaOSOQv2G24y2';
GRANT CONNECT ON DATABASE neondb TO student_user;
GRANT USAGE ON SCHEMA public TO student_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO student_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO student_user;

-- Test the new user

-- Test read access
SELECT * FROM patients;

-- Test write access
INSERT INTO patients (name,surname,email,username,password) VALUES ('value1', 'value2','value3', 'value4','value5');

-- Test delete access
DELETE FROM patients WHERE patient_id = 9;

-- Verify schema alteration is not allowed (should fail)
CREATE TABLE test_table (id SERIAL PRIMARY KEY);

# Authentication

Install Necessary Packages

dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer
dotnet add package System.IdentityModel.Tokens.Jwt
dotnet add package Microsoft.AspNetCore.Identity

## body for login 
it fail
{
    "username": "username1",
    "password": "password1"
}
success
{
    "username": "admin",
    "password": "password"
}




