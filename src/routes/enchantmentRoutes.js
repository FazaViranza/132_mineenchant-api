const express = require("express");

const {
    getAllEnchantments,
    getEnchantmentById
} = require("../controllers/enchantmentController");

const validateApiKey = require("../middleware/apiKeyMiddleware");

const router = express.Router();

router.get("/", validateApiKey, getAllEnchantments);

router.get("/:id", validateApiKey, getEnchantmentById);

module.exports = router;