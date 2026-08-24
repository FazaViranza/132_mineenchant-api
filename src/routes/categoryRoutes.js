const express = require("express");

const {
    getAllCategories,
    getCategoryById
} = require("../controllers/categoryController");

const validateApiKey = require("../middleware/apiKeyMiddleware");

const router = express.Router();

router.get("/", validateApiKey, getAllCategories);
router.get("/:id", validateApiKey, getCategoryById);

module.exports = router;