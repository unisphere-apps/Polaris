<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .login-container h1 {
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-control:focus {
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            border-color: #80bdff;
        }

        .btn-primary {
            width: 100%;
        }

        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <h1>Connexion</h1>

        <!-- Affiche les messages d'erreur ou de succès -->
        <% 
            String error = request.getParameter("error");
            String success = request.getParameter("success");

            if ("invalid_credentials".equals(error)) {
        %>
            <div class="alert alert-danger" role="alert">
                Email ou mot de passe incorrect.
            </div>
        <% 
            } else if ("missing_fields".equals(error)) { 
        %>
            <div class="alert alert-danger" role="alert">
                Veuillez remplir tous les champs.
            </div>
        <% 
            } else if ("logout".equals(success)) { 
        %>
            <div class="alert alert-success" role="alert">
                Vous vous êtes déconnecté avec succès.
            </div>
        <% 
            } 
        %>

        <!-- Formulaire de connexion -->
        <form action="auth" method="post">
            <div class="form-group">
                <label for="email">Email :</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="Entrez votre email" required>
            </div>
            <div class="form-group">
                <label for="password">Mot de passe :</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Entrez votre mot de passe" required>
            </div>
            <button type="submit" class="btn btn-primary">Se connecter</button>
        </form>

        <p class="text-center mt-3">
            Pas encore de compte ? <a href="http://localhost/unisphere/lobby/index.php?page=inscription">S'inscrire</a>
        </p>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
