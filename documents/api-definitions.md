# 1 Authentication

## 1.1 POST /login

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
token

example

{
	"token": "37s1MD5IW2XCr0LZ3XukTIJh357SiIkm"
}


### Annotations
