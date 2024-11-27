package controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import modele.Modele;
import controleur.Ticket;

@WebServlet("/tickets")
public class TicketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TicketServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            // Retrieve categories from Modele and set as request attribute
            ArrayList<Categorie> lesCategories = Modele.selectAllCategories();
            request.setAttribute("lesCategories", lesCategories);

            // Forward to the create-ticket.jsp page
            request.getRequestDispatcher("create-ticket.jsp").forward(request, response);
        } else {
            // Default action: view tickets
            ArrayList<Ticket> lesTickets = Controleur.getAllTickets();
            request.setAttribute("lesTickets", lesTickets);

            // Forward to see-ticket.jsp
            request.getRequestDispatcher("see-ticket.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            // Retrieve form parameters
            String sujet = request.getParameter("sujet");
            String description = request.getParameter("description");

            // Retrieve the user ID of the logged-in user from the session
            HttpSession session = request.getSession(false);
            Integer userId = null;
            if (session != null && session.getAttribute("userId") != null) {
                userId = (Integer) session.getAttribute("userId");
            }

            // Check if userId is null (not logged in)
            if (userId == null) {
                response.sendRedirect("login.jsp?error=not_logged_in");
                return;
            }

            // Check for "categorie_id" parameter and parse it
            Integer categorieId = null;
            String categorieIdStr = request.getParameter("categorie_id");
            if (categorieIdStr != null && !categorieIdStr.isEmpty()) {
                try {
                    categorieId = Integer.parseInt(categorieIdStr);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    // Optionally handle the error or leave "categorieId" as null if parsing fails
                }
            }

            // Create a new Ticket object
            Ticket newTicket = new Ticket(0, new java.util.Date(), sujet, description, "ouvert", userId, categorieId);

            // Save the ticket using Modele
            Modele.saveTicket(newTicket);

            // Redirect to the list of tickets after creation
            response.sendRedirect("tickets");
        } else {
            // Default to displaying the ticket list
            doGet(request, response);
        }
    }
}
