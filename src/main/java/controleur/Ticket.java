package controleur;

import java.util.Date;

public class Ticket {
    private int idTicket;
    private Date dateCreation;
    private String sujet;
    private String description;
    private String statut;
    private int userId;
    private Integer categorieId;

    public Ticket(int idTicket, Date dateCreation, String sujet, String description, String statut, int userId, Integer categorieId) {
        super();
        this.idTicket = idTicket;
        this.dateCreation = dateCreation;
        this.sujet = sujet;
        this.description = description;
        this.statut = statut;
        this.userId = userId;
        this.categorieId = categorieId;
    }

    public Ticket(Date dateCreation, String sujet, String description, String statut, int userId, Integer categorieId) {
        super();
        this.idTicket = 0;
        this.dateCreation = dateCreation;
        this.sujet = sujet;
        this.description = description;
        this.statut = statut;
        this.userId = userId;
        this.categorieId = categorieId;
    }

    // Getters et setters
    public int getIdTicket() {
        return idTicket;
    }

    public void setIdTicket(int idTicket) {
        this.idTicket = idTicket;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    public String getSujet() {
        return sujet;
    }

    public void setSujet(String sujet) {
        this.sujet = sujet;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Integer getCategorieId() {
        return categorieId;
    }

    public void setCategorieId(Integer categorieId) {
        this.categorieId = categorieId;
    }
}
