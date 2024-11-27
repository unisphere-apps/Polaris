package controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modele.Modele;

import java.io.IOException;

@WebServlet("/messages")
public class MessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MessageServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les paramètres du formulaire
        String ticketIdParam = request.getParameter("ticketId");
        String contenu = request.getParameter("contenu");

        if (ticketIdParam == null || contenu == null || contenu.trim().isEmpty()) {
            // Gérer l'erreur si des paramètres sont manquants
            response.sendRedirect("tickets?error=missing_parameters");
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdParam);
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userId") == null) {
                // L'utilisateur n'est pas connecté
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = (int) session.getAttribute("userId");

            // Ajouter la nouvelle réponse dans la base de données
            boolean success = Modele.addReponse(ticketId, userId, contenu);

            if (success) {
                // Rediriger vers la page du ticket après succès
                response.sendRedirect("tickets?ticketId=" + ticketId);
            } else {
                // Gérer l'échec de l'ajout
                response.sendRedirect("tickets?ticketId=" + ticketId + "&error=add_failed");
            }

        } catch (NumberFormatException e) {
            // Gérer l'erreur si ticketId n'est pas un entier valide
            response.sendRedirect("tickets?error=invalid_ticket_id");
        }
    }
}
