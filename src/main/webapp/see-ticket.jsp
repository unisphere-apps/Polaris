<%@ page import="java.util.ArrayList" %>
<%@ page import="modele.Modele" %>
<%@ page import="controleur.*" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");
    Integer userId = (Integer) session.getAttribute("userId");
    Integer roleId = (Integer) session.getAttribute("roleId"); // Récupération du rôle depuis la session

    if (userEmail == null || userId == null || roleId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Ticket> lesTickets = (ArrayList<Ticket>) request.getAttribute("lesTickets");
    ArrayList<Ticket> filteredTickets = new ArrayList<>(); // Liste filtrée des tickets

    // Filtrage des tickets si l'utilisateur a role_id = 1
    if (roleId == 1) {
        for (Ticket ticket : lesTickets) {
            if (ticket.getUserId() == userId) {
                filteredTickets.add(ticket); // Inclure uniquement les tickets associés à cet utilisateur
            }
        }
    } else {
        filteredTickets = lesTickets; // Tous les tickets pour les autres rôles
    }

    Ticket selectedTicket = null;
    User ticketUser = null;
    Categorie ticketCategory = null;

    String selectedTicketId = request.getParameter("ticketId");
    if (selectedTicketId != null && filteredTickets != null) {
        for (Ticket ticket : filteredTickets) {
            if (String.valueOf(ticket.getIdTicket()).equals(selectedTicketId)) {
                selectedTicket = ticket;
                ticketUser = Modele.getUserById(ticket.getUserId());
                if (ticket.getCategorieId() != null) {
                    ticketCategory = Modele.getCategorieById(ticket.getCategorieId());
                }
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Details</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .ticket-list-item {
            background-color: #ff914d;
            color: white;
            text-align: center;
            padding: 10px;
            border-radius: 20px;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .ticket-list-item:hover {
            background-color: #ff7a29;
        }

        .pill {
            background-color: #4cded7;
            color: black;
            padding: 5px 15px;
            border-radius: 20px;
            text-align: center;
            margin-right: 10px;
            font-weight: bold;
        }

        .description-box {
            background-color: #4cded7;
            color: black;
            padding: 20px;
            border-radius: 20px;
            text-align: left;
            max-width: 100%;
            font-weight: bold;
        }

        .message-bubble {
            background-color: #e9ecef;
            color: black;
            padding: 10px 20px;
            border-radius: 10px;
            margin: 10px 0;
            text-align: left;
            font-weight: normal;
        }

        .message-bubble.admin {
            background-color: #007bff;
            color: white;
        }

        .message-bubble small {
            display: block;
            margin-top: 5px;
            font-size: 12px;
        }

        .message-bubble.admin small {
            color: white;
        }

        .main-content-wrapper {
            background-color: #f8f9fa;
            padding: 40px 300px;
            border-radius: 15px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            max-width: 100%;
        }
    </style>
</head>

<body>
    <div class="container-fluid" style="padding-top: 20px;">
        <div class="row">
            <!-- Sidebar with Ticket List -->
            <div class="col-md-3 col-lg-2 p-3">
                <% 
                    if (filteredTickets != null) {
                        for (Ticket ticket : filteredTickets) {
                            boolean isSelected = selectedTicket != null && ticket.getIdTicket() == selectedTicket.getIdTicket();
                            boolean isClosed = "fermé".equalsIgnoreCase(ticket.getStatut());
                %>
                            <form action="tickets" method="get">
                                <input type="hidden" name="ticketId" value="<%= ticket.getIdTicket() %>">
                                <button type="submit" 
                                        class="ticket-list-item btn btn-block <%= isSelected ? "bg-warning" : (isClosed ? "bg-danger" : "") %>">
                                    <%= ticket.getSujet() %>
                                </button>
                            </form>
                <%
                        }
                    }
                %>
            </div>

            <!-- Main Content for Ticket Details and Messages -->
            <div class="col-md-9 col-lg-10">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <a href="home.jsp" class="btn btn-secondary btn-lg">Retour à l'accueil</a>
                    <h2>Détails du ticket</h2>
                    <a href="/Polaris/tickets?action=create" class="btn btn-primary btn-lg">Créer un ticket</a>
                </div>

                <div class="main-content-wrapper mt-2">
                    <!-- Ticket Details -->
                    <% if (selectedTicket != null) { %>
                        <div class="d-flex justify-content-center mb-4">
                            <div class="pill">Sujet: <%= selectedTicket.getSujet() %></div>
                            <div class="pill">Catégorie: <%= ticketCategory != null ? ticketCategory.getNom() : "-" %></div>
                            <div class="pill">Statut: <%= selectedTicket.getStatut() %></div>
                            <div class="pill">
                                Utilisateur: <%= ticketUser != null ? ticketUser.getNom() + " " + ticketUser.getPrenom() : "Inconnu" %>
                            </div>
                        </div>

                        <div class="description-box mb-4">
                            Description: <%= selectedTicket.getDescription() %>
                        </div>
                        
                        <% if (roleId == 2 || roleId == 3) { %> <!-- Supposons que roleId == 2 signifie administrateur -->
						    <div class="mb-4">
						        <form action="tickets" method="post" class="form-inline">
						            <input type="hidden" name="action" value="updateStatus">
						            <input type="hidden" name="ticketId" value="<%= selectedTicket.getIdTicket() %>">
						            <label for="newStatus" class="mr-2">Changer le statut :</label>
						            <select name="newStatus" class="form-control mr-2">
						                <option value="ouvert" <%= "ouvert".equalsIgnoreCase(selectedTicket.getStatut()) ? "selected" : "" %>>Ouvert</option>
						                <option value="fermé" <%= "fermé".equalsIgnoreCase(selectedTicket.getStatut()) ? "selected" : "" %>>Fermé</option>
						            </select>
						            <button type="submit" class="btn btn-success">Mettre à jour</button>
						        </form>
						    </div>
						<% } %>
                        

                        <!-- Messages Section -->
                        <div class="d-flex flex-column align-items-start">
                            <% 
                                ArrayList<ReponseTicket> messages = Modele.getReponsesByTicketId(selectedTicket.getIdTicket());
                                if (messages != null) {
                                    for (ReponseTicket message : messages) {
                                        boolean isAdminMessage = Modele.isAdmin(message.getUserId());
                            %>
                                        <div class="message-bubble <%= isAdminMessage ? "admin align-self-end" : "align-self-start" %>">
                                            <%= message.getContenu() %>
                                            <small><%= message.getDateReponse() %></small>
                                        </div>
                            <%
                                    }
                                }
                            %>
                        </div>

                        <!-- Input to Submit a New Message -->
                        <div class="mt-4">
                            <form action="messages" method="post" class="d-flex align-items-center">
                                <input type="hidden" name="ticketId" value="<%= selectedTicket.getIdTicket() %>">
                                <input type="text" class="form-control" name="contenu" placeholder="Écrivez votre message ici..." required>
                                <button type="submit" class="btn btn-primary ml-2">Envoyer</button>
                            </form>
                        </div>
                    <% } else { %>
                        <div class="alert alert-warning">Aucun ticket sélectionné.</div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
