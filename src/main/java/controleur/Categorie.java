package controleur;

public class Categorie {
    private int idCategorie;
    private String nom;

    // Constructeur complet
    public Categorie(int idCategorie, String nom) {
        super();
        this.idCategorie = idCategorie;
        this.nom = nom;
    }

    // Constructeur sans id (par exemple pour une insertion où l'ID est généré automatiquement)
    public Categorie(String nom) {
        super();
        this.idCategorie = 0;
        this.nom = nom;
    }

    // Getters et setters
    public int getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(int idCategorie) {
        this.idCategorie = idCategorie;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
