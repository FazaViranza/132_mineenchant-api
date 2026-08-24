const express = require("express");

const {
    getAllItems,
    getItemById
} = require("../controllers/itemController");

const validateApiKey = require("../middleware/apiKeyMiddleware");

const router = express.Router();

router.get("/", validateApiKey, getAllItems);

router.get("/:id", validateApiKey, getItemById);

module.exports = router;