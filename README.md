# MineEnchant API

## Final Project Pengembangan Aplikasi Web

MineEnchant API adalah sebuah aplikasi **Software as a Service (SaaS)** yang menyediakan data seputar enchantment Minecraft kepada pengguna melalui REST API.

Konsep aplikasi ini mirip dengan layanan API seperti OpenRouter atau Weather API, di mana pengguna dapat:

- Membuat akun
- Login menggunakan JWT Authentication
- Mendapatkan API Key
- Mengakses data API menggunakan API Key
- Mengambil data enchantment Minecraft
- Mengambil data item Minecraft
- Mengambil data kategori enchantment

API ini dibangun menggunakan **Express.js**, **PostgreSQL/Supabase**, dan dideploy menggunakan **Vercel**.

---

# Developer

**Nama:** Nofila Faza Viranza  
**NIM:** 20240140132  

---

# Live Deployment

Vercel:

https://132-mineenchant-api.vercel.app/

GitHub Repository:

https://github.com/FazaViranza/132_mineenchant-api

---

# Tech Stack

Project ini menggunakan teknologi berikut:

- Node.js
- Express.js
- PostgreSQL
- Supabase
- JSON Web Token (JWT)
- bcryptjs
- Vercel
- Postman

---

# Features

## 1. User Authentication

Sistem menyediakan fitur authentication menggunakan JWT.

User dapat:

- Register
- Login
- Mendapatkan JWT Token
- Mengakses endpoint yang membutuhkan authentication

---

## 2. API Key Management

Setelah user memiliki akun dan melakukan authentication, user dapat membuat API Key.

API Key digunakan untuk mengakses endpoint data MineEnchant API.

Contoh penggunaan:

```http
x-api-key: YOUR_API_KEY
```

3. Enchantment API

MineEnchant menyediakan data enchantment Minecraft.

Data yang tersedia mencakup informasi seperti:

Nama enchantment
Deskripsi
Level
Kategori
Item yang kompatibel

Contoh endpoint:

GET /api/v1/enchantments
4. Item API

API menyediakan data item Minecraft yang dapat digunakan dengan enchantment tertentu.

Contoh endpoint:

GET /api/v1/items
5. Category API

API menyediakan kategori enchantment.

Contoh endpoint:

GET /api/v1/categories

Contoh kategori yang tersedia:

All Purpose
Armor
Melee Weapons
Ranged Weapons
Tools
Database

MineEnchant API menggunakan PostgreSQL yang dihosting menggunakan Supabase.

Database terdiri dari beberapa tabel utama:
| Table                  | Description                        |
| ---------------------- | ---------------------------------- |
| users                  | Menyimpan data pengguna            |
| api_keys               | Menyimpan API Key pengguna         |
| enchantments           | Menyimpan data enchantment         |
| categories             | Menyimpan kategori enchantment     |
| items                  | Menyimpan data item Minecraft      |
| enchantment_categories | Relasi enchantment dengan kategori |
| enchantment_items      | Relasi enchantment dengan item     |

Database memiliki relasi antar tabel untuk mendukung data enchantment yang lebih kompleks.

Total data yang tersedia telah memenuhi requirement minimal project.

Project Structure
```
132_mineenchant-api
│
├── api
│   └── index.js
│
├── database
│   ├── schema.sql
│   └── seed.sql
│
├── src
│   │
│   ├── config
│   │   └── db.js
│   │
│   ├── controllers
│   │   ├── apiKeyController.js
│   │   ├── authController.js
│   │   ├── categoryController.js
│   │   ├── enchantmentController.js
│   │   └── itemController.js
│   │
│   ├── middleware
│   │   ├── apiKeyMiddleware.js
│   │   └── authMiddleware.js
│   │
│   ├── public
│   │   ├── css
│   │   │   └── style.css
│   │   │
│   │   ├── js
│   │   │   ├── auth.js
│   │   │   └── dashboard.js
│   │   │
│   │   ├── dashboard.html
│   │   ├── index.html
│   │   ├── login.html
│   │   └── register.html
│   │
│   └── routes
│       ├── apiKeyRoutes.js
│       ├── authRoutes.js
│       ├── categoryRoutes.js
│       ├── enchantmentRoutes.js
│       └── itemRoutes.js
│
├── .env
├── .gitignore
├── package.json
├── package-lock.json
└── vercel.json
```

Installation

Clone repository:
```
git clone https://github.com/FazaViranza/132_mineenchant-api.git

Masuk ke folder project:

cd 132_mineenchant-api

Install dependency:

npm install
Environment Variables

Buat file .env pada root project.

Contoh konfigurasi:

POSTGRES_URL=your_postgresql_connection_string

PORT=3000

JWT_SECRET=mineenchant_super_secret_key

JWT_EXPIRES=1d
```

Contoh POSTGRES_URL:
```
POSTGRES_URL=postgresql://username:password@host:port/database?sslmode=require
Running the Application
```
Jalankan project menggunakan:
```
npm start
```
Atau menggunakan nodemon:
```
npm run dev
```
Server akan berjalan pada:
```
http://localhost:3000
API Status
```
Untuk memastikan API dan database berjalan dengan baik:
```
GET /api/status
```
Contoh response:
```
{
    "message": "MineEnchant API is running",
    "status": "running",
    "database": "connected",
    "server_time": "2026-08-25T23:39:04.010Z"
}
```
Authentication
Register

Endpoint:
```
POST /api/auth/register
```
Contoh request body:
```
{
    "username": "exampleuser",
    "email": "example@email.com",
    "password": "password123"
}
```
Login

Endpoint:
```
POST /api/auth/login
```
Contoh request body:
```
{
    "email": "example@email.com",
    "password": "password123"
}
```
Setelah login berhasil, server akan memberikan JWT Token yang digunakan untuk authentication.

JWT Authentication

Endpoint tertentu membutuhkan JWT Token.

Token dapat dikirim melalui Authorization Header:

Authorization: Bearer YOUR_JWT_TOKEN
API Key

MineEnchant menggunakan API Key untuk melindungi endpoint data.

API Key dikirim melalui request header:

x-api-key: YOUR_API_KEY

Jika API Key tidak dikirim, API akan memberikan response:
```
{
    "message": "API key required"
}
```
API Endpoints
Authentication
| Method | Endpoint             | Description        |
| ------ | -------------------- | ------------------ |
| POST   | `/api/auth/register` | Register user baru |
| POST   | `/api/auth/login`    | Login user         |

API Key
| Method        | Endpoint        | Description        |
| ------------- | --------------- | ------------------ |
| API Key Route | `/api/api-keys` | API Key management |

Enchantments

Endpoint:
```
GET /api/v1/enchantments
```
Header:
```
x-api-key: YOUR_API_KEY
```
Items

Endpoint:
```
GET /api/v1/items
```
Header:
```
x-api-key: YOUR_API_KEY
```
Categories

Endpoint:
```
GET /api/v1/categories
```
Header:
```
x-api-key: YOUR_API_KEY
```
Contoh response:
```
{
    "message": "Categories retrieved successfully",
    "total": 5,
    "data": [
        {
            "id": 1,
            "name": "All Purpose"
        },
        {
            "id": 2,
            "name": "Armor"
        },
        {
            "id": 3,
            "name": "Melee Weapons"
        },
        {
            "id": 4,
            "name": "Ranged Weapons"
        },
        {
            "id": 5,
            "name": "Tools"
        }
    ]
}
```
Example Request

Contoh request menggunakan cURL:
```
curl -X GET "http://localhost:3000/api/v1/categories" \
-H "x-api-key: YOUR_API_KEY"
```

Untuk deployment Vercel:
```
curl -X GET "https://132-mineenchant-api.vercel.app/api/v1/categories" \
-H "x-api-key: YOUR_API_KEY"
```
Deployment

Aplikasi dideploy menggunakan Vercel.

Live API:
```
https://132-mineenchant-api.vercel.app/
```
Contoh API Status:
```
https://132-mineenchant-api.vercel.app/api/status
```
SaaS Concept

MineEnchant API menerapkan konsep Software as a Service (SaaS).

Sistem menyediakan data kepada pengguna melalui API.

Alur penggunaan aplikasi:
```
User
  │
  ▼
Register Account
  │
  ▼
Login
  │
  ▼
Receive JWT Token
  │
  ▼
Create / Obtain API Key
  │
  ▼
Send API Request
  │
  ▼
API Key Validation
  │
  ▼
Access Minecraft Enchantment Data
```

Dengan konsep ini, pengguna dapat menggunakan MineEnchant API sebagai sumber data untuk aplikasi atau project mereka sendiri.

API Security

MineEnchant API menggunakan beberapa mekanisme keamanan:

Password Hashing

Password user tidak disimpan dalam bentuk plain text.

Password diamankan menggunakan:

bcryptjs
JWT Authentication

JWT digunakan untuk memastikan endpoint authentication hanya dapat digunakan oleh user yang telah login.

API Key Authentication

Endpoint data MineEnchant dilindungi menggunakan API Key.

Setiap request ke endpoint API harus menyertakan:

x-api-key: YOUR_API_KEY
Testing

API telah diuji menggunakan Postman.

Beberapa endpoint yang telah diuji:
```
GET /api/status

POST /api/auth/register

POST /api/auth/login

API Key Management

GET /api/v1/enchantments

GET /api/v1/items

GET /api/v1/categories
```

Contoh hasil testing:
```

Status: 200 OK
```
Database juga berhasil terhubung dengan Supabase PostgreSQL.

Deployment Architecture
```
                    ┌───────────────┐
                    │     User      │
                    └───────┬───────┘
                            │
                            ▼
                    ┌───────────────┐
                    │    Vercel     │
                    │  Express API  │
                    └───────┬───────┘
                            │
                            ▼
                    ┌───────────────┐
                    │   Supabase    │
                    │  PostgreSQL   │
                    └───────────────┘
```

Requirements Fulfillment

Project ini telah memenuhi requirement final project:
```
 Menggunakan konsep SaaS
 Menyediakan data melalui REST API
 Menggunakan API Key
 Menggunakan JWT Authentication
 Menggunakan Express.js
 Menggunakan PostgreSQL
 Menggunakan Supabase
 Minimal 2 tabel
 Menyediakan lebih dari 50 data
 Memiliki relasi database
 Dideploy menggunakan Vercel
 Memiliki GitHub Repository
 Memiliki dokumentasi laporan
```
Links
```
GitHub Repository

https://github.com/FazaViranza/132_mineenchant-api

Live API

https://132-mineenchant-api.vercel.app/

API Status

https://132-mineenchant-api.vercel.app/api/status
```
Author

Nofila Faza Viranza

NIM: 20240140132

Final Project - Pengembangan Aplikasi Web

Universitas Muhammadiyah Yogyakarta
