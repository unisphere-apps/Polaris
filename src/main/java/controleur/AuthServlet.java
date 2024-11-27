package controleur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modele.Modele;

import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=missing_fields");
            return;
        }

        boolean isAuthenticated = Modele.authenticateUser(email, password);

        if (isAuthenticated) {
            // Retrieve the userId from the database using the email
            int userId = Modele.getUserIdByEmail(email);
            if (userId == -1) {
                // If userId is not found, redirect with an error
                response.sendRedirect("login.jsp?error=user_not_found");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userId", userId); // Add userId to the session

            System.out.println("User authenticated: " + email + ", userId: " + userId); // Log for debugging
            response.sendRedirect("home.jsp");
        } else {
            System.out.println("Authentication failed for email: " + email); // Log for debugging
            response.sendRedirect("login.jsp?error=invalid_credentials");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            System.out.println("Unknown action in doGet: " + action); // Log for debugging
            response.sendRedirect("login.jsp");
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            System.out.println("User logged out"); // Log for debugging
        }
        response.sendRedirect("login.jsp?success=logout");
    }
}
