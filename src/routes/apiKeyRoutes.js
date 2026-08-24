const express = require("express");

const {
    createApiKey,
    getApiKeys,
    deleteApiKey
} = require("../controllers/apiKeyController");

const authenticateToken = require("../middleware/authMiddleware");

const router = express.Router();

router.post("/", authenticateToken, createApiKey);

router.get("/", authenticateToken, getApiKeys);

router.delete("/:id", authenticateToken, deleteApiKey);

module.exports = router;