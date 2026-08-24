const crypto = require("crypto");

const generateApiKey = () => {
    const randomKey = crypto.randomBytes(24).toString("hex");

    return `mc_live_${randomKey}`;
};

module.exports = generateApiKey;