<%@ page import="java.util.ArrayList" %>
<%@ page import="modele.Modele" %>
<%@ page import="controleur.*" %>


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
            text-align: center;
            max-width: 100%;
            font-weight: bold;
        }

        .message-bubble {
            background-color: #51c9ff;
            color: black;
            padding: 10px 20px;
            border-radius: 20px;
            margin: 10px 0;
            text-align: center;
            font-weight: bold;
        }

        .main-content-wrapper {
            background-color: #f8f9fa;
            padding: 40px 300px; /* Increased padding on sides */
            border-radius: 15px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            max-width: 100%;
        }
    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar with Ticket List -->
			<div class="col-md-3 col-lg-2 p-3">
			    <% 
			        ArrayList<Ticket> lesTickets = (ArrayList<Ticket>) request.getAttribute("lesTickets");
			        if (lesTickets != null) {
			            for (Ticket ticket : lesTickets) {
			    %>
			                <div class="ticket-list-item"
			                     data-sujet="<%= ticket.getSujet() %>"
			                     data-categorie="<%= ticket.getCategorieId() != null ? ticket.getCategorieId() : "" %>" 
			                     data-statut="<%= ticket.getStatut() %>"
			                     data-description="<%= ticket.getDescription() %>">
			                    <%= ticket.getSujet() %>
			                </div>
			    <%
			            }
			        }
			    %>
			</div>



            <!-- Main Content for Ticket Details and Messages -->
			<div class="col-md-9 col-lg-10">
			    <div class="main-content-wrapper mt-5">
			        <!-- Ticket Details -->
			        <div class="d-flex justify-content-center mb-4">
			            <div class="pill"><span id="sujet">Sélectionnez un ticket</span></div>
			            <div class="pill"><span id="categorie">-</span></div>
			            <div class="pill"><span id="statut">-</span></div>
			        </div>
			
			        <div class="description-box mb-4">
			            Description: <span id="description">Cliquez sur un ticket pour voir les détails</span>
			        </div>
			
			        <!-- Messages Section (optional) -->
			        <div class="d-flex flex-column align-items-start">
			            <div class="message-bubble align-self-start">Message 1</div>
			            <div class="message-bubble align-self-end">Message 2</div>
			            <div class="message-bubble align-self-start">Message 3</div>
			        </div>
			    </div>
			</div>
        </div>
    </div>
    
	<script>
	    document.addEventListener("DOMContentLoaded", function () {
	        // Select all ticket items in the sidebar
	        const ticketItems = document.querySelectorAll(".ticket-list-item");
	
	        // Add click event listeners to each ticket item
	        ticketItems.forEach(function (ticketItem) {
	            ticketItem.addEventListener("click", function () {
	                // Get the data attributes from the clicked ticket item
	                const sujet = this.getAttribute("data-sujet");
	                const categorie = this.getAttribute("data-categorie");
	                const statut = this.getAttribute("data-statut");
	                const description = this.getAttribute("data-description");
	
	                // Update the main content fields with the ticket's information
	                document.getElementById("sujet").textContent = sujet;
	                document.getElementById("categorie").textContent = categorie;
	                document.getElementById("statut").textContent = statut;
	                document.getElementById("description").textContent = description;
	            });
	        });
	    });
	</script>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
