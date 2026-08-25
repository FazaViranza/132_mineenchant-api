const express = require("express");
const cors = require("cors");
const path = require("path");

require("dotenv").config();

const pool = require("./src/config/db");

const authRoutes = require("./src/routes/authRoutes");
const apiKeyRoutes = require("./src/routes/apiKeyRoutes");
const enchantmentRoutes = require("./src/routes/enchantmentRoutes");
const itemRoutes = require("./src/routes/itemRoutes");
const categoryRoutes = require("./src/routes/categoryRoutes");

const app = express();

app.use(cors());
app.use(express.json());

// Frontend
app.use(express.static(
    path.join(__dirname, "src/public")
));

// API Routes
app.use("/api/auth", authRoutes);
app.use("/api/api-keys", apiKeyRoutes);
app.use("/api/v1/enchantments", enchantmentRoutes);
app.use("/api/v1/items", itemRoutes);
app.use("/api/v1/categories", categoryRoutes);


// API Status
app.get("/api/status", async (req, res) => {

    try {

        const result = await pool.query(
            "SELECT NOW()"
        );

        res.json({
            message: "MineEnchant API is running",
            status: "running",
            database: "connected",
            server_time: result.rows[0].now
        });

    } catch (error) {

        console.error(error);

        res.status(500).json({
            message: "Database connection failed",
            error: error.message
        });

    }

});

if (require.main === module) {

    const PORT = process.env.PORT || 3000;

    app.listen(PORT, () => {
        console.log(
            `Server running on port ${PORT}`
        );
    });

}


module.exports = app;