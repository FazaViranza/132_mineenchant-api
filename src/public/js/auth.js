const messageBox = document.getElementById("message");

const showMessage = (message, type = "error") => {
    if (!messageBox) return;

    messageBox.textContent = message;
    messageBox.className = `form-message ${type}`;
};


const registerForm = document.getElementById("registerForm");

if (registerForm) {

    registerForm.addEventListener("submit", async (event) => {

        event.preventDefault();

        const username = document
            .getElementById("username")
            .value
            .trim();

        const email = document
            .getElementById("email")
            .value
            .trim();

        const password = document
            .getElementById("password")
            .value;


        try {

            const response = await fetch("/api/auth/register", {

                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify({
                    username,
                    email,
                    password
                })

            });


            const data = await response.json();


            if (!response.ok) {

                showMessage(
                    data.message || "Registration failed."
                );

                return;
            }


            showMessage(
                "Account created successfully! Redirecting...",
                "success"
            );


            setTimeout(() => {

                window.location.href = "/login.html";

            }, 1200);


        } catch (error) {

            showMessage(
                "Unable to connect to server."
            );

        }

    });

}



const loginForm = document.getElementById("loginForm");

if (loginForm) {

    loginForm.addEventListener("submit", async (event) => {

        event.preventDefault();


        const email = document
            .getElementById("email")
            .value
            .trim();

        const password = document
            .getElementById("password")
            .value;


        try {

            const response = await fetch("/api/auth/login", {

                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify({
                    email,
                    password
                })

            });


            const data = await response.json();


            if (!response.ok) {

                showMessage(
                    data.message || "Login failed."
                );

                return;
            }


            localStorage.setItem(
                "mineenchant_token",
                data.token
            );


            localStorage.setItem(
                "mineenchant_user",
                JSON.stringify(data.user)
            );


            showMessage(
                "Login successful! Loading dashboard...",
                "success"
            );


            setTimeout(() => {

                window.location.href = "/dashboard.html";

            }, 700);


        } catch (error) {

            showMessage(
                "Unable to connect to server."
            );

        }

    });

}