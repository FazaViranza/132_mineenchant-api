const token = localStorage.getItem("mineenchant_token");

const user = JSON.parse(
    localStorage.getItem("mineenchant_user")
);


if (!token || !user) {

    window.location.href = "/login.html";

}


const usernameElement =
    document.getElementById("username");

const avatarLetter =
    document.getElementById("avatarLetter");


if (user) {

    usernameElement.textContent = user.username;

    avatarLetter.textContent =
        user.username.charAt(0).toUpperCase();

}


const keyContainer =
    document.getElementById("apiKeyContainer");

const keyCount =
    document.getElementById("keyCount");

const keyTotal =
    document.getElementById("keyTotal");

const keyMessage =
    document.getElementById("keyMessage");


const showKeyMessage = (
    message,
    type = "error"
) => {

    keyMessage.textContent = message;

    keyMessage.className =
        `form-message ${type}`;

};


const loadApiKeys = async () => {

    try {

        const response = await fetch(
            "/api/api-keys",
            {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }
        );


        const data =
            await response.json();


        if (!response.ok) {

            if (response.status === 401 ||
                response.status === 403) {

                localStorage.removeItem(
                    "mineenchant_token"
                );

                localStorage.removeItem(
                    "mineenchant_user"
                );

                window.location.href =
                    "/login.html";

                return;
            }


            throw new Error(
                data.message
            );

        }


        renderApiKeys(
            data.api_keys
        );


    } catch (error) {

        keyContainer.innerHTML = `
            <div class="empty-state">
                <div>⚠️</div>
                <h3>Unable to load API Keys</h3>
                <p>${error.message}</p>
            </div>
        `;

    }

};


const renderApiKeys = (keys) => {

    keyCount.textContent =
        keys.length;

    keyTotal.textContent =
        `${keys.length} key${keys.length !== 1 ? "s" : ""}`;


    if (keys.length === 0) {

        keyContainer.innerHTML = `

            <div class="empty-state">

                <div>🔑</div>

                <h3>No API Keys Yet</h3>

                <p>
                    Generate your first API key to
                    start using the API.
                </p>

            </div>

        `;

        return;

    }


    keyContainer.innerHTML =
        keys.map(key => `

            <div class="api-key-row">

                <div class="key-info">

                    <div class="key-icon">
                        🔑
                    </div>

                    <div>

                        <strong>
                            ${escapeHtml(key.name)}
                        </strong>

                        <code>
                            ${escapeHtml(key.api_key)}
                        </code>

                        <small>
                            Created ${new Date(
                                key.created_at
                            ).toLocaleDateString()}
                        </small>

                    </div>

                </div>


                <div class="key-actions">

                    <span class="status active">
                        Active
                    </span>


                    <button
                        class="icon-btn"
                        onclick="copyApiKey('${key.api_key}')"
                        title="Copy API Key"
                    >
                        📋
                    </button>


                    <button
                        class="icon-btn delete"
                        onclick="deleteApiKey(${key.id})"
                        title="Delete API Key"
                    >
                        🗑
                    </button>

                </div>

            </div>

        `).join("");

};


const escapeHtml = (text) => {

    const div =
        document.createElement("div");

    div.textContent = text;

    return div.innerHTML;

};


document
    .getElementById("generateKeyBtn")
    ?.addEventListener(
        "click",
        async () => {

            const input =
                document.getElementById("keyName");

            const name =
                input.value.trim() ||
                "Default API Key";


            try {

                const response =
                    await fetch(
                        "/api/api-keys",
                        {

                            method: "POST",

                            headers: {

                                "Content-Type":
                                    "application/json",

                                Authorization:
                                    `Bearer ${token}`

                            },

                            body:
                                JSON.stringify({
                                    name
                                })

                        }
                    );


                const data =
                    await response.json();


                if (!response.ok) {

                    throw new Error(
                        data.message ||
                        "Failed to generate API key."
                    );

                }


                input.value = "";

                showKeyMessage(
                    "API Key generated successfully! 🔥",
                    "success"
                );


                loadApiKeys();


            } catch (error) {

                showKeyMessage(
                    error.message
                );

            }

        }
    );


window.copyApiKey = async (apiKey) => {

    try {

        await navigator.clipboard.writeText(
            apiKey
        );

        showKeyMessage(
            "API Key copied to clipboard!",
            "success"
        );

    } catch (error) {

        showKeyMessage(
            "Unable to copy API key."
        );

    }

};


window.deleteApiKey = async (id) => {

    const confirmed =
        confirm(
            "Are you sure you want to delete this API Key?"
        );


    if (!confirmed) return;


    try {

        const response =
            await fetch(
                `/api/api-keys/${id}`,
                {

                    method: "DELETE",

                    headers: {

                        Authorization:
                            `Bearer ${token}`

                    }

                }
            );


        const data =
            await response.json();


        if (!response.ok) {

            throw new Error(
                data.message
            );

        }


        showKeyMessage(
            "API Key deleted successfully.",
            "success"
        );


        loadApiKeys();


    } catch (error) {

        showKeyMessage(
            error.message
        );

    }

};


document
    .getElementById("logoutBtn")
    ?.addEventListener(
        "click",
        () => {

            localStorage.removeItem(
                "mineenchant_token"
            );

            localStorage.removeItem(
                "mineenchant_user"
            );

            window.location.href =
                "/";

        }
    );

const loadStats = async () => {

    try {

        const response = await fetch(
            "/api/api-keys",
            {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            }
        );

        const keyData = await response.json();

        if (!response.ok) {
            throw new Error(
                keyData.message || "Failed to load API keys"
            );
        }

        const keys = keyData.api_keys;

        // Kalau belum punya API key
        if (keys.length === 0) {
            return;
        }

        // Ambil API key pertama
        const apiKey = keys[0].api_key;

        // Fetch semua data secara bersamaan
        const [
            enchantmentResponse,
            itemResponse,
            categoryResponse
        ] = await Promise.all([

            fetch(
                "/api/v1/enchantments",
                {
                    headers: {
                        "x-api-key": apiKey
                    }
                }
            ),

            fetch(
                "/api/v1/items",
                {
                    headers: {
                        "x-api-key": apiKey
                    }
                }
            ),

            fetch(
                "/api/v1/categories",
                {
                    headers: {
                        "x-api-key": apiKey
                    }
                }
            )

        ]);

        const enchantmentData =
            await enchantmentResponse.json();

        const itemData =
            await itemResponse.json();

        const categoryData =
            await categoryResponse.json();


        // Update stats di HTML
        document.getElementById(
            "enchantmentCount"
        ).textContent =
            enchantmentData.total || 0;


        document.getElementById(
            "itemCount"
        ).textContent =
            itemData.total || 0;


        document.getElementById(
            "categoryCount"
        ).textContent =
            categoryData.total || 0;


    } catch (error) {

        console.error(
            "Failed to load dashboard stats:",
            error
        );

    }

};


loadApiKeys();
loadStats();