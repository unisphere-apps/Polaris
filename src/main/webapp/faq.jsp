<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ - Comment créer un ticket</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .faq-container {
            max-width: 900px;
            margin: 50px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .faq-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .faq-header h1 {
            font-size: 32px;
            font-weight: bold;
            color: #007bff;
        }

        .faq-section {
            margin-bottom: 20px;
        }

        .faq-section h3 {
            font-size: 20px;
            color: #007bff;
            margin-bottom: 10px;
        }

        .faq-section p {
            font-size: 16px;
            color: #333;
            margin-bottom: 10px;
        }

        .faq-section ul {
            padding-left: 20px;
            list-style-type: disc;
        }

        .faq-section ul li {
            margin-bottom: 10px;
            color: #555;
        }

        .back-button {
            display: block;
            text-align: center;
            margin-top: 30px;
        }

        .back-button a {
            font-size: 16px;
            color: #ffffff;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-button a:hover {
            background-color: #0056b3;
        }
    </style>
</head>

<body>
    <div class="faq-container">
        <div class="faq-header">
            <h1>FAQ - Comment créer un ticket ?</h1>
        </div>

        <!-- Section: Introduction -->
        <div class="faq-section">
            <h3>Qu'est-ce qu'un ticket ?</h3>
            <p>Un ticket est un moyen de signaler un problème, de poser une question ou de soumettre une demande d'assistance à l'équipe de support. Chaque ticket est suivi jusqu'à sa résolution.</p>
        </div>

        <!-- Section: Étapes pour créer un ticket -->
        <div class="faq-section">
            <h3>Comment créer un ticket ?</h3>
            <p>Pour créer un ticket, suivez ces étapes :</p>
            <ul>
                <li>Connectez-vous à votre compte en utilisant vos identifiants.</li>
                <li>Accédez à la page d'accueil et cliquez sur le bouton <strong>"Créer un ticket"</strong>.</li>
                <li>Remplissez le formulaire avec les informations nécessaires :</li>
                <ul>
                    <li><strong>Sujet :</strong> Une brève description du problème ou de la demande.</li>
                    <li><strong>Description :</strong> Expliquez en détail le problème ou la demande. Fournissez autant d'informations que possible pour faciliter la résolution.</li>
                    <li><strong>Catégorie :</strong> Sélectionnez la catégorie appropriée (par exemple : "Problème technique", "Demande d'information", etc.).</li>
                </ul>
                <li>Soumettez le formulaire en cliquant sur le bouton <strong>"Envoyer"</strong>.</li>
            </ul>
        </div>

        <!-- Section: Spécificités des tickets -->
        <div class="faq-section">
            <h3>Spécificités des tickets</h3>
            <p>Voici quelques points importants à noter concernant les tickets :</p>
            <ul>
                <li>Les tickets peuvent être <strong>"ouverts"</strong> ou <strong>"fermés"</strong>. Un ticket fermé ne peut plus recevoir de réponses.</li>
                <li>Seuls les administrateurs peuvent réouvrir un ticket fermé.</li>
                <li>Chaque ticket est assigné à un utilisateur et peut inclure des réponses des administrateurs.</li>
                <li>Les réponses des administrateurs apparaissent dans une couleur différente pour être facilement identifiables.</li>
            </ul>
        </div>

        <!-- Section: Catégories disponibles -->
        <div class="faq-section">
            <h3>Quelles sont les catégories disponibles ?</h3>
            <p>Lors de la création d'un ticket, vous pouvez sélectionner l'une des catégories suivantes :</p>
            <ul>
                <li><strong>Problème technique :</strong> Signaler un bug ou un problème technique.</li>
                <li><strong>Demande d'information :</strong> Poser une question ou demander des détails.</li>
                <li><strong>Assistance générale :</strong> Toute autre demande d'aide.</li>
            </ul>
        </div>

        <!-- Section: Suivi des tickets -->
        <div class="faq-section">
            <h3>Comment suivre mes tickets ?</h3>
            <p>Une fois votre ticket créé, vous pouvez le suivre en :</p>
            <ul>
                <li>Accédant à la page <strong>"Voir mes tickets"</strong> depuis l'accueil.</li>
                <li>Consultant les réponses de l'équipe de support directement sur la page du ticket.</li>
            </ul>
        </div>

        <!-- Back Button -->
        <div class="back-button">
            <a href="home.jsp">Retour à l'accueil</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
