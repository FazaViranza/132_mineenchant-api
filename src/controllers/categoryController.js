const pool = require("../config/db");

const getAllCategories = async (req, res) => {
    try {
        const result = await pool.query(`
            SELECT id, name
            FROM categories
            ORDER BY id ASC
        `);

        return res.status(200).json({
            message: "Categories retrieved successfully",
            total: result.rows.length,
            data: result.rows
        });

    } catch (error) {
        console.error("Get categories error:", error);

        return res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
};


const getCategoryById = async (req, res) => {
    try {
        const { id } = req.params;

        // Get category
        const categoryResult = await pool.query(
            `
            SELECT id, name
            FROM categories
            WHERE id = $1
            `,
            [id]
        );

        if (categoryResult.rows.length === 0) {
            return res.status(404).json({
                message: "Category not found"
            });
        }

        const category = categoryResult.rows[0];

        // Get enchantments in this category
        const enchantmentResult = await pool.query(
            `
            SELECT
                e.id,
                e.name,
                e.description,
                e.max_level
            FROM enchantments e
            JOIN enchantment_categories ec
                ON e.id = ec.enchantment_id
            WHERE ec.category_id = $1
            ORDER BY e.id ASC
            `,
            [id]
        );

        return res.status(200).json({
            message: "Category retrieved successfully",
            data: {
                ...category,
                enchantments: enchantmentResult.rows
            }
        });

    } catch (error) {
        console.error("Get category error:", error);

        return res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
};


module.exports = {
    getAllCategories,
    getCategoryById
};