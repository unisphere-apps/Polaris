package controleur;

import java.util.Date;

public class ReponseTicket {
    private int idReponse;
    private Date dateReponse;
    private String contenu;
    private int userId;
    private int ticketId;

    public ReponseTicket(int idReponse, Date dateReponse, String contenu, int userId, int ticketId) {
        super();
        this.idReponse = idReponse;
        this.dateReponse = dateReponse;
        this.contenu = contenu;
        this.userId = userId;
        this.ticketId = ticketId;
    }

    public ReponseTicket(Date dateReponse, String contenu, int userId, int ticketId) {
        super();
        this.idReponse = 0;
        this.dateReponse = dateReponse;
        this.contenu = contenu;
        this.userId = userId;
        this.ticketId = ticketId;
    }

    public int getIdReponse() {
        return idReponse;
    }

    public void setIdReponse(int idReponse) {
        this.idReponse = idReponse;
    }

    public Date getDateReponse() {
        return dateReponse;
    }

    public void setDateReponse(Date dateReponse) {
        this.dateReponse = dateReponse;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        this.contenu = contenu;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }
}
