package controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modele.Modele;

import java.io.IOException;

@WebServlet("/ticket-status")
public class ChangeTicketStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ChangeTicketStatusServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les paramètres depuis le formulaire
        String ticketIdParam = request.getParameter("ticketId");
        String action = request.getParameter("action");

        // Vérifier que les paramètres nécessaires sont présents
        if (ticketIdParam == null || ticketIdParam.isEmpty() || action == null || action.isEmpty()) {
            response.sendRedirect("tickets?error=missing_parameters");
            return;
        }

        try {
            // Convertir ticketId en entier
            int ticketId = Integer.parseInt(ticketIdParam);

            // Déterminer le nouveau statut basé sur l'action
            String newStatus = "ouvert"; // Valeur par défaut
            if ("fermer".equalsIgnoreCase(action)) {
                newStatus = "fermé";
            } else if (!"reouvrir".equalsIgnoreCase(action)) {
                // Action invalide
                response.sendRedirect("tickets?ticketId=" + ticketId + "&error=invalid_action");
                return;
            }

            // Appeler la méthode du modèle pour changer le statut
            boolean success = Modele.changeTicketStatus(ticketId, newStatus);

            if (success) {
                // Rediriger vers la page du ticket si la mise à jour a réussi
                response.sendRedirect("tickets?ticketId=" + ticketId);
            } else {
                // Rediriger avec une erreur si la mise à jour a échoué
                response.sendRedirect("tickets?ticketId=" + ticketId + "&error=update_failed");
            }

        } catch (NumberFormatException e) {
            // Gérer une erreur si ticketId n'est pas un entier valide
            response.sendRedirect("tickets?error=invalid_ticket_id");
        } catch (Exception e) {
            // Gérer les erreurs générales
            e.printStackTrace();
            response.sendRedirect("tickets?error=unexpected_error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Si quelqu'un tente un GET, renvoyer une erreur 405
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not allowed for this endpoint.");
    }
}
