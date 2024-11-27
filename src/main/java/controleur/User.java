package controleur;

public class User {
    private int idUser;
    private String nom;
    private String prenom;
    private String etablissement;
    private String email;
    private String mdp;
    private int roleId;

    public User(int idUser, String nom, String prenom, String etablissement, String email, String mdp, int roleId) {
        this.idUser = idUser;
        this.nom = nom;
        this.prenom = prenom;
        this.etablissement = etablissement;
        this.email = email;
        this.mdp = mdp;
        this.roleId = roleId;
    }

    // Getters and Setters
    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}

