const pool = require("../config/db");
const generateApiKey = require("../utils/generateApiKey");

const createApiKey = async (req, res) => {
    try {
        const { name } = req.body;

        const apiKey = generateApiKey();

        const result = await pool.query(
            `INSERT INTO api_keys (user_id, api_key, name)
             VALUES ($1, $2, $3)
             RETURNING id, api_key, name, is_active, created_at`,
            [
                req.user.id,
                apiKey,
                name || "Default API Key"
            ]
        );

        return res.status(201).json({
            message: "API key created successfully",
            api_key: result.rows[0]
        });

    } catch (error) {
        console.error("Create API key error:", error);

        return res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
};


const getApiKeys = async (req, res) => {
    try {
        const result = await pool.query(
            `SELECT id, api_key, name, is_active, created_at
             FROM api_keys
             WHERE user_id = $1
             ORDER BY created_at DESC`,
            [req.user.id]
        );

        return res.status(200).json({
            api_keys: result.rows
        });

    } catch (error) {
        console.error("Get API keys error:", error);

        return res.status(500).json({
            message: "Internal server error"
        });
    }
};


const deleteApiKey = async (req, res) => {
    try {
        const { id } = req.params;

        const result = await pool.query(
            `DELETE FROM api_keys
             WHERE id = $1 AND user_id = $2
             RETURNING id`,
            [id, req.user.id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({
                message: "API key not found"
            });
        }

        return res.status(200).json({
            message: "API key deleted successfully"
        });

    } catch (error) {
        console.error("Delete API key error:", error);

        return res.status(500).json({
            message: "Internal server error"
        });
    }
};


module.exports = {
    createApiKey,
    getApiKeys,
    deleteApiKey
};