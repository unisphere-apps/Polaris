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
            // Récupérer l'utilisateur complet par son email
            int userId = Modele.getUserIdByEmail(email);
            User user = Modele.getUserById(userId); // Utilisation de getUserById pour récupérer l'utilisateur

            if (user == null) {
                // Si l'utilisateur n'est pas trouvé, rediriger avec une erreur
                response.sendRedirect("login.jsp?error=user_not_found");
                return;
            }

            // Créer une session et stocker les informations utilisateur
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userId", user.getIdUser());
            session.setAttribute("roleId", user.getRoleId()); // Stocker le role_id dans la session

            System.out.println("User authenticated: " + user.getEmail() + ", userId: " + user.getIdUser() + ", roleId: " + user.getRoleId()); // Log pour le débogage
            response.sendRedirect("home.jsp");
        } else {
            System.out.println("Authentication failed for email: " + email); // Log pour le débogage
            response.sendRedirect("login.jsp?error=invalid_credentials");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            System.out.println("Unknown action in doGet: " + action); // Log pour le débogage
            response.sendRedirect("login.jsp");
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            System.out.println("User logged out"); // Log pour le débogage
        }
        response.sendRedirect("login.jsp?success=logout");
    }
}
