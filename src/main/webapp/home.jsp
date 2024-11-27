<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
        <div class="btn-group" role="group">
            <a href="index.jsp?page=1" class="btn btn-primary btn-lg mx-2">FAQ</a>
            <a href="tickets?action=create" class="btn btn-primary btn-lg mx-2">Créer un ticket</a>
            <a href="tickets" class="btn btn-primary btn-lg mx-2">Voir mes tickets</a>
            <form action="auth" method="get" style="display: inline;">
                <input type="hidden" name="action" value="logout">
                <button type="submit" class="btn btn-danger btn-lg mx-2">Déconnexion</button>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
