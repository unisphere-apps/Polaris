package controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import modele.Modele;
import controleur.*;

@WebServlet("/tickets") // Setting the URL pattern to /tickets
public class TicketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TicketServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve all tickets from the controller
        ArrayList<Ticket> lesTickets = Controleur.getAllTickets();

        // Pass the list of tickets to the JSP page
        request.setAttribute("lesTickets", lesTickets);

        // Forward the request to see-ticket.jsp
        request.getRequestDispatcher("see-ticket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
