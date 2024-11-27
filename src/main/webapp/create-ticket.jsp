<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controleur.Categorie" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Créer un Ticket</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f0f2f5;
        }

        .container {
            max-width: 500px;
            background-color: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>

<body>

    <div class="container">
        <h3 class="text-center mb-4">Créer un Ticket</h3>

        <form action="tickets?action=create" method="post">
            <div class="form-group">
                <label for="sujet">Sujet</label>
                <input type="text" class="form-control" id="sujet" name="sujet" placeholder="Entrez le sujet du ticket" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea class="form-control" id="description" name="description" placeholder="Entrez la description du problème" rows="3" required></textarea>
            </div>
            <div class="form-group">
                <label for="categorie_id">Catégorie</label>
                <select class="form-control" id="categorie_id" name="categorie_id" required>
                    <%
                        // Get categories from request attribute set in the servlet
                        ArrayList<Categorie> lesCategories = (ArrayList<Categorie>) request.getAttribute("lesCategories");
                        if (lesCategories != null) {
                            for (Categorie categorie : lesCategories) {
                    %>
                                <option value="<%= categorie.getIdCategorie() %>"><%= categorie.getNom() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <div class="form-group d-flex justify-content-between">
                <a href="/Polaris" class="btn btn-danger">Annuler</a>
                <button type="submit" class="btn btn-success">Valider</button>
            </div>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
