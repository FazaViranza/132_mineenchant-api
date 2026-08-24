const pool = require("../config/db");

const validateApiKey = async (req, res, next) => {
    try {
        const apiKey = req.headers["x-api-key"];

        if (!apiKey) {
            return res.status(401).json({
                message: "API key required"
            });
        }

        const result = await pool.query(
            `SELECT id, user_id, api_key, is_active
             FROM api_keys
             WHERE api_key = $1`,
            [apiKey]
        );

        if (result.rows.length === 0) {
            return res.status(403).json({
                message: "Invalid API key"
            });
        }

        const key = result.rows[0];

        if (!key.is_active) {
            return res.status(403).json({
                message: "API key is inactive"
            });
        }

        req.apiKey = key;

        next();

    } catch (error) {
        console.error("API Key validation error:", error);

        return res.status(500).json({
            message: "Internal server error"
        });
    }
};

module.exports = validateApiKey;