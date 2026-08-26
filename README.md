MineEnchant API

SaaS REST API untuk menyediakan data Minecraft Enchantment yang dapat digunakan oleh aplikasi atau developer lain melalui API Key.

Project: MineEnchant API
Nama: Nofila Faza Viranza
NIM: 20240140132
Program Studi: Teknologi Informasi
Universitas: Universitas Muhammadiyah Yogyakarta
Tahun: 2026

1. Tentang Project

MineEnchant API adalah aplikasi Software as a Service (SaaS) berbasis REST API yang menyediakan data Minecraft secara terstruktur.

Konsep utama project ini adalah menyediakan data melalui API sehingga aplikasi lain tidak perlu menyimpan dan mengelola dataset Minecraft sendiri.

Client dapat mengakses endpoint API menggunakan API Key melalui HTTP header x-api-key.

Selain mekanisme API Key untuk konsumsi API, sistem juga menggunakan JWT (JSON Web Token) untuk autentikasi pengguna pada fitur yang membutuhkan login.

Tujuan

Menyediakan data Minecraft melalui REST API.

Menyediakan dataset yang cukup kompleks untuk digunakan oleh aplikasi lain.

Menggunakan API Key untuk membatasi akses API.

Menggunakan JWT untuk autentikasi user.

Menggunakan PostgreSQL/Supabase sebagai database.

Melakukan deployment backend menggunakan Vercel.

2. Tech Stack

Teknologi

Fungsi

Node.js

JavaScript runtime

Express.js

Backend REST API

PostgreSQL

Relational database

Supabase

PostgreSQL production database

JWT

Authentication

bcryptjs

Password hashing

CORS

Cross-origin request handling

dotenv

Environment variable management

Vercel

Deployment

Postman

API testing

3. Production

API URL

https://132-mineenchant-api.vercel.app/

API Status

Endpoint:

GET /api/status

Contoh:

GET https://132-mineenchant-api.vercel.app/api/status

Response:

{
  "message": "MineEnchant API is running",
  "status": "running",
  "database": "connected",
  "server_time": "2026-08-25T23:39:04.010Z"
}

GitHub Repository

https://github.com/FazaViranza/132_mineenchant-api

4. Fitur Utama

Authentication

User dapat melakukan:

Register

Login

Mendapatkan JWT setelah login

JWT digunakan untuk mengakses fitur yang membutuhkan autentikasi.

API Key

Client menggunakan API Key untuk mengakses public API.

API Key dikirim melalui header:

x-api-key: YOUR_API_KEY

Jika API Key tidak diberikan, server akan memberikan response:

{
  "message": "API key required"
}

Minecraft Data API

API menyediakan beberapa kelompok data:

Enchantments

Categories

Items

Relasi Enchantments dan Categories

Relasi Enchantments dan Items

5. Database

Database menggunakan PostgreSQL dan dikelola pada Supabase.

Struktur utama database:

users
  │
  └──< api_keys

categories
  │
  └──< enchantment_categories >── enchantments

items
  │
  └──< enchantment_items >── enchantments

Tables

users

Menyimpan akun pengguna.

Contoh informasi:

ID

Username

Email

Password yang telah di-hash

api_keys

Menyimpan API Key yang digunakan client untuk mengakses REST API.

Contoh informasi:

ID

User ID

Nama/key identifier

API Key

Status aktif

enchantments

Menyimpan data utama Minecraft enchantments.

Production database berisi 43 enchantments.

categories

Menyimpan kategori enchantment.

Production database berisi 5 categories.

items

Menyimpan item Minecraft yang berhubungan dengan enchantment.

Production database berisi 16 items.

enchantment_categories

Tabel penghubung many-to-many antara enchantments dan categories.

Production database berisi 45 records.

enchantment_items

Tabel penghubung many-to-many antara enchantments dan items.

Production database berisi 121 records.

Dataset

Data production yang telah diverifikasi:

Table

Records

enchantments

43

categories

5

items

16

enchantment_categories

45

enchantment_items

121

users

0*

api_keys

0*

Total domain + relationship records: 230

users dan api_keys bergantung pada aktivitas user dan bukan bagian dari dataset Minecraft seed.

6. Authentication Flow

JWT Flow

User
 │
 ▼
Login
 │
 ▼
Validate Credentials
 │
 ├── Invalid → Error Response
 │
 ▼
Generate JWT
 │
 ▼
Client stores JWT
 │
 ▼
Authenticated Request

JWT digunakan untuk membuktikan bahwa request berasal dari user yang telah berhasil melakukan login.

Password user tidak disimpan sebagai plaintext. Password diproses menggunakan bcryptjs.

7. API Key Flow

Client
 │
 │ x-api-key
 ▼
Express.js
 │
 ▼
API Key Middleware
 │
 ├── Missing → 401
 │
 ├── Invalid → 401
 │
 ▼
Controller
 │
 ▼
PostgreSQL / Supabase
 │
 ▼
JSON Response

API Key dipisahkan dari JWT agar credential untuk mengonsumsi API tidak sama dengan credential autentikasi user.

8. API Documentation

8.1 Authentication

Register

POST /api/auth/register

Contoh request:

{
  "username": "example",
  "email": "example@email.com",
  "password": "password123"
}

Login

POST /api/auth/login

Contoh request:

{
  "email": "example@email.com",
  "password": "password123"
}

Response berhasil akan menyediakan JWT yang digunakan untuk request terproteksi.

8.2 API Key

Get API Keys

GET /api/api-keys

Endpoint ini digunakan untuk melihat API Key milik user yang telah terautentikasi.

Create API Key

POST /api/api-keys

Endpoint ini digunakan untuk membuat API Key baru.

Request membutuhkan JWT.

Delete API Key

DELETE /api/api-keys/:id

Endpoint ini digunakan untuk menghapus API Key.

Request membutuhkan JWT.

9. Public REST API

Endpoint public API berada di bawah:

/api/v1

Public endpoint menggunakan API Key.

9.1 Categories

Get Categories

GET /api/v1/categories

Header:

x-api-key: YOUR_API_KEY

Contoh production:

GET https://132-mineenchant-api.vercel.app/api/v1/categories

Response yang telah diuji:

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
    }
  ]
}

Response production mengembalikan 5 categories.

9.2 Items

Get Items

GET /api/v1/items

Header:

x-api-key: YOUR_API_KEY

Endpoint mengembalikan data item Minecraft yang tersedia pada database.

Production database berisi 16 items.

9.3 Enchantments

Get Enchantments

GET /api/v1/enchantments

Header:

x-api-key: YOUR_API_KEY

Production database berisi 43 enchantments.

10. API Key Example

Setelah memperoleh API Key, client dapat melakukan request seperti:

GET https://132-mineenchant-api.vercel.app/api/v1/categories
x-api-key: YOUR_API_KEY

Jangan menuliskan API Key asli ke source code, README, atau repository public.

11. Error Handling

API menggunakan HTTP status code untuk menunjukkan hasil request.

Contoh ketika API Key tidak diberikan:

{
  "message": "API key required"
}

Status:

401 Unauthorized

Contoh ketika API berhasil:

200 OK

Response dikembalikan dalam format JSON.

12. Project Structure

Struktur project:

132_mineenchant-api/
│
├── api/
│   └── index.js
│
├── database/
│   ├── schema.sql
│   └── seed.sql
│
├── src/
│   ├── config/
│   │   └── db.js
│   │
│   ├── controllers/
│   │   ├── apiKeyController.js
│   │   ├── authController.js
│   │   ├── categoryController.js
│   │   ├── enchantmentController.js
│   │   └── itemController.js
│   │
│   ├── middleware/
│   │   ├── apiKeyMiddleware.js
│   │   └── authMiddleware.js
│   │
│   ├── public/
│   │   ├── css/
│   │   │   └── style.css
│   │   ├── js/
│   │   │   ├── auth.js
│   │   │   └── dashboard.js
│   │   ├── dashboard.html
│   │   ├── index.html
│   │   ├── login.html
│   │   └── register.html
│   │
│   ├── routes/
│   │   ├── apiKeyRoutes.js
│   │   ├── authRoutes.js
│   │   ├── categoryRoutes.js
│   │   ├── enchantmentRoutes.js
│   │   └── itemRoutes.js
│   │
│   └── utils/
│
├── .env
├── .gitignore
├── index.js
├── package.json
├── package-lock.json
└── vercel.json

13. Local Installation

Requirements

Pastikan sudah terinstall:

Node.js

npm

PostgreSQL atau akses Supabase

Git

Clone Repository

git clone https://github.com/FazaViranza/132_mineenchant-api.git

Masuk ke folder:

cd 132_mineenchant-api

Install dependencies:

npm install

14. Environment Variables

Buat file:

.env

Gunakan format:

POSTGRES_URL=YOUR_DATABASE_URL

PORT=3000

JWT_SECRET=YOUR_JWT_SECRET

JWT_EXPIRES=1d

Untuk production, environment variables dikonfigurasi melalui Vercel.

Jangan commit .env ke GitHub.

15. Database Setup

Database schema tersedia pada:

database/schema.sql

Seed data tersedia pada:

database/seed.sql

Jika menggunakan Supabase:

Buka project Supabase.

Masuk ke SQL Editor.

Jalankan schema.

Jalankan seed.

Pastikan tabel berhasil dibuat.

Pastikan data berhasil masuk.

Hubungkan POSTGRES_URL ke aplikasi.

Setelah database siap, endpoint berikut dapat digunakan untuk mengecek koneksi:

GET /api/status

Response yang diharapkan:

{
  "message": "MineEnchant API is running",
  "status": "running",
  "database": "connected"
}

16. Running Locally

Jalankan:

npm start

Server berjalan pada:

http://localhost:3000

Untuk development menggunakan nodemon:

npm run dev

17. Testing with Postman

Contoh request:

GET http://localhost:3000/api/v1/categories

Tambahkan header:

x-api-key: YOUR_API_KEY

Expected result:

200 OK

Tanpa API Key:

GET http://localhost:3000/api/v1/categories

Expected result:

401 Unauthorized

Dengan response:

{
  "message": "API key required"
}

18. Deployment

Project dideploy menggunakan Vercel.

Database production menggunakan Supabase PostgreSQL.

Deployment flow:

GitHub Repository
       │
       ▼
     Vercel
       │
       ▼
  Express.js API
       │
       ▼
Supabase PostgreSQL

Environment variables production disimpan pada Vercel dan tidak ditulis langsung di source code.

Production URL:

https://132-mineenchant-api.vercel.app/

Status endpoint:

https://132-mineenchant-api.vercel.app/api/status

19. Security

Project menerapkan beberapa mekanisme keamanan:

Password Hashing

Password tidak disimpan dalam plaintext dan diproses menggunakan bcryptjs.

JWT

JWT digunakan untuk autentikasi user.

API Key

Public API membutuhkan API Key melalui:

x-api-key

Environment Variables

Credential database dan secret tidak ditulis langsung di source code production.

20. Testing Checklist

Test

Expected Result

GET /api/status

200 OK

Database connection

Connected

Register

User created

Login

JWT generated

Request tanpa API Key

401

Request dengan API Key valid

200

GET categories

5 records

GET items

16 records

GET enchantments

43 records

Production deployment

Accessible via Vercel

21. Screenshots / Evidence

Untuk dokumentasi project dan laporan, screenshot yang direkomendasikan:

Screenshot 1 — Vercel Deployment

Tampilkan halaman deployment Vercel yang menunjukkan:

Project name

Deployment status Ready

Production URL

Screenshot 2 — Supabase Database

Tampilkan Supabase Table Editor atau SQL Editor yang menunjukkan tabel:

users
api_keys
enchantments
categories
items
enchantment_categories
enchantment_items

Screenshot 3 — Dataset

Tampilkan hasil query/count yang membuktikan:

enchantments = 43
categories = 5
items = 16
enchantment_categories = 45
enchantment_items = 121

Screenshot 4 — API Status

Postman/browser:

GET https://132-mineenchant-api.vercel.app/api/status

Dengan response:

{
  "message": "MineEnchant API is running",
  "status": "running",
  "database": "connected"
}

Screenshot 5 — API Key Authentication

Postman dengan:

x-api-key: YOUR_API_KEY

dan response 200 OK.

Screenshot 6 — Unauthorized Request

Postman tanpa API Key dan response:

{
  "message": "API key required"
}

Screenshot 7 — Categories / Items / Enchantments

Minimal satu screenshot Postman yang menunjukkan response data dari endpoint public API.

22. Project Requirements Checklist

Requirement

Status

SaaS

✅

REST API

✅

Express.js

✅

PostgreSQL / Supabase

✅

JWT Login

✅

API Key

✅

Minimal 2 tabel

✅

Dataset > 50 records

✅

Complex relational data

✅

ERD

✅

Use Case Diagram

✅

Activity Diagram / User Flow

✅

Vercel Deployment

✅

GitHub Repository

✅

Postman Testing

✅

23. Author

Nofila Faza Viranza
20240140132

Program Studi Teknologi Informasi
Fakultas Teknik
Universitas Muhammadiyah Yogyakarta

2026
