package controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/")
public class DefaultServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Vérifiez si l'utilisateur est déjà connecté
        if (session != null && session.getAttribute("userEmail") != null) {
            // Si connecté, redirigez vers la page "home"
            response.sendRedirect("home.jsp");
        } else {
            // Sinon, redirigez vers la page "login"
            response.sendRedirect("login.jsp");
        }
    }
}
