# README
-  rvm use ruby-3.0.0 
-  make a database in postgresql  "filehandlersystem_development"
-  rake db:migrate
-  rails s

For SignUP
```
curl --location 'http://localhost:3000/users' \
--header 'Content-Type: application/json' \
--data-raw '{
  "user": {
    "email": "user2@example.com",
    "password": "password@123",
    "confirmation_password": "password@123"
  }
}
'

```
Output
```
{
    "message": "Signed up successfully",
    "user": {
        "id": 2,
        "email": "user2@example.com",
        "created_at": "2025-01-03T19:10:17.491Z",
        "updated_at": "2025-01-03T19:10:17.491Z"
    }
}



```
For login (Authentication)
```
curl --location 'localhost:3000/login' \
--header 'Content-Type: application/json' \
--data-raw '{
  "email": "user1@example.com",
  "password": "password@123"
}
'

```
Output
```


{
    "message": "Login successful",
    "user": {
        "id": 1,
        "email": "user1@example.com",
        "created_at": "2025-01-03T18:55:58.471Z",
        "updated_at": "2025-01-03T18:55:58.471Z"
    },
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MzYwMTc4OTB9.9-DaCjCNWmbnhX9yzFfodoYOUulQwZTqdGikh-_cuaY"
}


```
For Personalized File After Getting from the Bearer Token insert into the Authorization
```
curl --location 'http://localhost:3000/users/files' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MzYwMTc4OTB9.9-DaCjCNWmbnhX9yzFfodoYOUulQwZTqdGikh-_cuaY'

```
Output
```
{
    "user": {
        "id": 1,
        "email": "user1@example.com",
        "created_at": "2025-01-03T18:55:58.471Z",
        "updated_at": "2025-01-03T18:55:58.471Z"
    },
    "files": [
        {
            "name": "POOJA_DONODE_RESUME.pdf",
            "url": "http://localhost:3000/s/p7VBiHu4",
            "type": "application/pdf"
        },
        {
            "name": "DriverInstallation.pdf",
            "url": "http://localhost:3000/s/E1b2kNJI",
            "type": "application/pdf"
        },
        {
            "name": "Screenshot from 2024-12-26 22-00-40.png",
            "url": "http://localhost:3000/s/Qr7r2S0z",
            "type": "image/png"
        }
    ]
}

```
For Upload
```

curl --location 'http://localhost:3000/users/upload' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE3MzYwMTc4MzF9.SZrJfASxX458QpVMfgaBFXCF13y4otOiAoyqpmCkqhI' \
--form 'file=@"/home/kaushik/Pictures/Screenshots/Screenshot from 2024-12-26 22-00-40.png"' \
--form 'title="Sample File"' \
--form 'description="This is a test file"'


```
Output
```
{
    "message": "File uploaded successfully",
    "user": {
        "id": 2,
        "email": "user2@example.com",
        "created_at": "2025-01-03T19:10:17.491Z",
        "updated_at": "2025-01-03T19:10:17.491Z"
    },
    "tiny_url": "http://localhost:3000/s/8YTswj3Y",
    "type": "image/png"
}

```
Deletion
```

curl --location 'localhost:3000/users/files/delete' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE3MzYwMTc4MzF9.SZrJfASxX458QpVMfgaBFXCF13y4otOiAoyqpmCkqhI' \
--header 'Content-Type: application/json' \
--data '{
    "id": 4
}'
```
Output
```

File Not Found (Either Different User File/ When ID is not present)
{
    "error": "File not found"
}



When File Deleted Successfully
{
  message: 'File deleted successfully'
}
