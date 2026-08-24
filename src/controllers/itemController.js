const pool = require("../config/db");

const getAllItems = async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT
                id,
                name
            FROM items
            ORDER BY id ASC
        `);

        return res.status(200).json({
            message: "Items retrieved successfully",
            total: result.rows.length,
            data: result.rows
        });

    } catch (error) {
        console.error("Get items error:", error);

        return res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
};


const getItemById = async (req, res) => {
    try {
        const { id } = req.params;

        // Get item
        const itemResult = await pool.query(
            `
            SELECT id, name
            FROM items
            WHERE id = $1
            `,
            [id]
        );

        if (itemResult.rows.length === 0) {
            return res.status(404).json({
                message: "Item not found"
            });
        }

        const item = itemResult.rows[0];

        // Get compatible enchantments
        const enchantmentResult = await pool.query(
            `
            SELECT
                e.id,
                e.name,
                e.description,
                e.max_level
            FROM enchantments e
            JOIN enchantment_items ei
                ON e.id = ei.enchantment_id
            WHERE ei.item_id = $1
            ORDER BY e.id ASC
            `,
            [id]
        );

        return res.status(200).json({
            message: "Item retrieved successfully",
            data: {
                ...item,
                compatible_enchantments: enchantmentResult.rows
            }
        });

    } catch (error) {
        console.error("Get item error:", error);

        return res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
};


module.exports = {
    getAllItems,
    getItemById
};