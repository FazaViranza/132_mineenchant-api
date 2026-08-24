const pool = require("../config/db");

const getAllEnchantments = async (req, res) => {
    try {
        const { category, item, search } = req.query;

        let query = `
            SELECT DISTINCT
                e.id,
                e.name,
                e.description,
                e.max_level
            FROM enchantments e
            LEFT JOIN enchantment_categories ec
                ON e.id = ec.enchantment_id
            LEFT JOIN categories c
                ON ec.category_id = c.id
            LEFT JOIN enchantment_items ei
                ON e.id = ei.enchantment_id
            LEFT JOIN items i
                ON ei.item_id = i.id
            WHERE 1=1
        `;

        const values = [];

        if (category) {
            values.push(category);

            query += `
                AND LOWER(c.name) = LOWER($${values.length})
            `;
        }

        if (item) {
            values.push(item);

            query += `
                AND LOWER(i.name) = LOWER($${values.length})
            `;
        }

        if (search) {
            values.push(`%${search}%`);

            query += `
                AND LOWER(e.name) LIKE LOWER($${values.length})
            `;
        }

        query += `
            ORDER BY e.id ASC
        `;

        const result = await pool.query(query, values);

        return res.status(200).json({
            message: "Enchantments retrieved successfully",
            total: result.rows.length,
            data: result.rows
        });

    } catch (error) {
        console.error("Get enchantments error:", error);

        return res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
};


const getEnchantmentById = async (req, res) => {
    try {
        const { id } = req.params;

        const enchantmentResult = await pool.query(
            `
            SELECT
                id,
                name,
                description,
                max_level
            FROM enchantments
            WHERE id = $1
            `,
            [id]
        );

        if (enchantmentResult.rows.length === 0) {
            return res.status(404).json({
                message: "Enchantment not found"
            });
        }

        const enchantment = enchantmentResult.rows[0];

        const categoryResult = await pool.query(
            `
            SELECT c.id, c.name
            FROM categories c
            JOIN enchantment_categories ec
                ON c.id = ec.category_id
            WHERE ec.enchantment_id = $1
            `,
            [id]
        );

        const itemResult = await pool.query(
            `
            SELECT i.id, i.name
            FROM items i
            JOIN enchantment_items ei
                ON i.id = ei.item_id
            WHERE ei.enchantment_id = $1
            `,
            [id]
        );

        return res.status(200).json({
            message: "Enchantment retrieved successfully",
            data: {
                ...enchantment,
                categories: categoryResult.rows,
                compatible_items: itemResult.rows
            }
        });

    } catch (error) {
        console.error("Get enchantment error:", error);

        return res.status(500).json({
            message: "Internal server error",
            error: error.message
        });
    }
};


module.exports = {
    getAllEnchantments,
    getEnchantmentById
};