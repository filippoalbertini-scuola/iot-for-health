# 1 Authentication

## 1.1 POST /api/login

### Authentication : none

### Request
role:string {PATIENT|CLINICIAN}
username:string
password:string

example

{
    "role": "CLINICIAN",
	"username": "name.surname",
	"password": "password"
}

### Response
token jwt

#### example

{
	"token": "37s1MD5IW2XCr0LZ3XukTIJh357SiIkm"
}


# 2 Patients

## 2.1 Get /api/patients

### Authentication : Bearer JWT

### Request
none

### Response
array of patient objects

#### example

[
  {
    "patient_id": 1,
    "name": "John",
    "surname": "Doe",
    "email": "john.doe@example.com",
    "username": "johndoe",
    "password": "password123"
  },
  {
    "patient_id": 7,
    "name": "name 1",
    "surname": "surname 1",
    "email": "johndoe@example.com",
    "username": "name.surname",
    "password": "password1"
  },
  {
    "patient_id": 2,
    "name": "name 22",
    "surname": "surname 22",
    "email": "johndoe22@example.com",
    "username": "name.surname22",
    "password": "password22"
  }
]

## 2.2 Get /api/patients/{{id}}

### Authentication : Bearer JWT

### Request
none

### Response
array of one patient object

#### example

[
  {
    "patient_id": 1,
    "name": "John",
    "surname": "Doe",
    "email": "john.doe@example.com",
    "username": "johndoe",
    "password": "password123"
  }
]
