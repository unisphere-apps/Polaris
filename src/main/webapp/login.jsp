<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h1>Connexion</h1>

    <!-- Affiche les messages d'erreur ou de succès -->
    <% 
        String error = request.getParameter("error");
        String success = request.getParameter("success");

        if ("invalid_credentials".equals(error)) {
    %>
        <p style="color: red;">Email ou mot de passe incorrect.</p>
    <% 
        } else if ("missing_fields".equals(error)) { 
    %>
        <p style="color: red;">Veuillez remplir tous les champs.</p>
    <% 
        } else if ("logout".equals(success)) { 
    %>
        <p style="color: green;">Vous vous êtes déconnecté avec succès.</p>
    <% 
        } 
    %>

    <!-- Formulaire de connexion -->
    <form action="auth" method="post">
        <label for="email">Email :</label>
        <input type="email" id="email" name="email" required>
        <br><br>
        <label for="password">Mot de passe :</label>
        <input type="password" id="password" name="password" required>
        <br><br>
        <button type="submit">Se connecter</button>
    </form>

    <p>Pas encore de compte ? <a href="register.jsp">S'inscrire</a></p>
</body>
</html>
