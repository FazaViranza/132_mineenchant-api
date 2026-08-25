const { Pool } = require("pg");

require("dotenv").config();

const connectionString = process.env.POSTGRES_URL;

// Hapus sslmode dari URL supaya konfigurasi SSL di bawah yang dipakai
const databaseUrl = new URL(connectionString);
databaseUrl.searchParams.delete("sslmode");

const pool = new Pool({
    connectionString: databaseUrl.toString(),
    ssl: {
        rejectUnauthorized: false
    }
});

pool.on("connect", () => {
    console.log("Connected to PostgreSQL database");
});

pool.on("error", (err) => {
    console.error("Database connection error:", err);
});

module.exports = pool;