package controleur;

import java.util.ArrayList;
import modele.Modele;

public class Controleur {

    // Ticket-related methods
    public static ArrayList<Ticket> getAllTickets() {
        return Modele.selectAllTickets();
    }

    // User-related methods
    
    public static boolean authenficateUser(String email, String password) {
    	return Modele.authenticateUser(email, password);
    }

    // Get a user by ID
    public static User getUserById(int idUser) {
        return Modele.getUserById(idUser);
    }

    // Get all users
    public static ArrayList<User> getAllUsers() {
        return Modele.getAllUsers();
    }

    // Save a new user
    public static void saveUser(User user) {
    	Modele.saveUser(user);
    }
}
