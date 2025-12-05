# **📘 Assessment System API — v1 Documentation**

## **Authentication**

كل طلب (ما عدا signup/login) لازم يحمل Header:

```
Authorization: Bearer <token>
Content-Type: application/json
```

---

# **📍 /api/v1/signup**

**Method:** `POST`
**Description:** Register a new user.

### **Request Body**

```json
{
  "name": "string",
  "email": "string",
  "phone": "string",
  "grade": "13-A",
  "password": "string"
}
```

### **Response — 201 Created**

```json
{
  "success": true,
  "message": "User Created",
  "data": {
    "token": "string"
  }
}
```

---

# **📍 /api/v1/login**

**Method:** `POST`

### **Request Body**

```json
{
  "email": "string",
  "password": "string"
}
```

### **Response — 200 OK**

```json
{
  "success": true,
  "message": "Success",
  "data": {
    "token": "string"
  }
}
```

---

# **📍 /api/v1/verify-token**

**Method:** `POST`

### **Request Body**

```json
{
  "token": "string"
}
```

### **Response — 200 OK**

```json
{
  "success": true,
  "message": "Success",
}
```

---

# **📍 /api/v1/get-assessment/:id**

**Method:** `POST`

### **Response — 200 OK**

```json
{
  "success": true,
  "message": "Assessment Loaded",
  "data": {
    "assessmentId": 12,
    "title": "Midterm Revision",
    "duration": 1800,
    "subject": "Math",
    "questions": [
      {
        "questionId": 1,
        "question": "What is 2+2?",
        "options": [
          { "optionId": 11, "text": "4" },
          { "optionId": 12, "text": "3" },
          { "optionId": 13, "text": "5" }
        ]
      }
    ]
  }
}
```

> **Note:** duration بالثواني (recommended).

---

# **📍 /api/v1/check-assessment**

**Method:** `POST`

### **Request Body (Optimized & Clean)**

```json
{
  "assessmentId": 12,
  "answers": [
    {
      "questionId": 1,
      "chosenOptionId": 11
    }
  ]
}
```

### **Response — 200 OK**

```json
{
  "success": true,
  "message": "Assessment Checked",
  "data": {
    "results": [
      {
        "questionId": 1,
        "correctOptionId": 11,
        "isCorrect": true
      }
    ],
    "score": 1,
    "totalScore": 1
  }
}
```

---

# **📍 /api/v1/get-profile**

**Method:** `GET`

### **Response — 200 OK**

```json
{
  "success": true,
  "message": "Profile Loaded",
  "data": {
    "name": "Solomon",
    "email": "solomon@mail.com",
    "grade": "14-A",
    "average": 89.3
  }
}
```

---

# **📍 /api/v1/period-scores-analysis**

**Method:** `GET`

### **Response — 200 OK**

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "Jan": 85.2,
    "Feb": 90.1,
    "Mar": 87.0,
    "Apr": 92.4,
    "May": 84.0,
    "Jun": 89.7
  }
}
```

---

# **📍 /api/v1/subjects-scores-analysis**

**Method:** `GET`

### **Response — 200 OK**

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "En": 88.3,
    "Ar": 90.0,
    "Math": 85.7,
    "Flutter": 92.5,
    "DS": 89.4,
    "SS": 91.1
  }
}
```

---

# **📍 /api/v1/history**

**Method:** `GET`

### **Response — 200 OK**

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "totalAssessments": 14,
    "assessments": [
      {
        "id": 12,
        "title": "Math Midterm",
        "subject": "Math",
        "score": 18,
        "total": 20,
        "submittedAt": "2025-11-22T12:32:10Z"
      }
    ]
  }
}
```

---

# **🧱 Standard Error Response**

### **Example — 401 Unauthorized**

```json
{
  "success": false,
  "message": "Invalid or expired token",
}
```

### **Example — 422 Validation Error**

```json
{
  "success": false,
  "message": "Validation Error",
  "data": {
    "email": "Invalid format",
    "password": "Minimum 8 characters"
  }
}
```

---

# **📌 Naming Conventions**

* كل الـ Keys → **camelCase**
* token → في الـ Header فقط
* duration → seconds integer
* questions/options/answers → consistent mapping

---

# **جاهز لو عايز أدوّنهولك كـ Postman Collection أو OpenAPI (Swagger) JSON/YAML.**
