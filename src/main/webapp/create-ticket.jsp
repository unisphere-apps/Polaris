<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Créer un Ticket</title>
    <!-- Inclure Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Style personnalisé pour centrer le conteneur */
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

        <form method="post">
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
                    <!-- Remplacez ces options par les catégories disponibles -->
                    <option value="1">Informatique</option>
                    <option value="2">Santé</option>
                    <option value="3">Pédagogique</option>
                    <option value="4">Autres</option>
                </select>
            </div>
            <div class="form-group d-flex justify-content-between">
                <button type="reset" class="btn btn-danger">Annuler</button>
                <button type="submit" class="btn btn-success">Valider</button>
            </div>
        </form>
    </div>

    <!-- Inclure jQuery et Bootstrap JS pour les interactions et la compatibilité -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
