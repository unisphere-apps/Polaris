USE unisphere;

-- Création de la table des catégories
CREATE TABLE IF NOT EXISTS `POL_categorie` (
  `id_categorie` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insertion des catégories de base
INSERT INTO `POL_categorie` (nom) VALUES 
    ('Support Technique'),
    ('Bug'),
    ('Demande de Fonctionnalité'),
    ('Question Générale'),
    ('Autre');

-- Création de la table des tickets
CREATE TABLE IF NOT EXISTS `POL_ticket` (
  `id_ticket` int(11) NOT NULL AUTO_INCREMENT,
  `date_creation` datetime NOT NULL,
  `sujet` varchar(255) NOT NULL,
  `description` text,
  `statut` ENUM('ouvert', 'fermé') DEFAULT 'ouvert',
  `user_id` int(11) NOT NULL,
  `categorie_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ticket`),
  FOREIGN KEY (`user_id`) REFERENCES `user`(`id_user`) ON DELETE CASCADE,
  FOREIGN KEY (`categorie_id`) REFERENCES `POL_categorie`(`id_categorie`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Création de la table des réponses aux tickets
CREATE TABLE IF NOT EXISTS `POL_reponse_ticket` (
  `id_reponse` int(11) NOT NULL AUTO_INCREMENT,
  `date_reponse` datetime NOT NULL,
  `contenu` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  PRIMARY KEY (`id_reponse`),
  FOREIGN KEY (`user_id`) REFERENCES `user`(`id_user`) ON DELETE CASCADE,
  FOREIGN KEY (`ticket_id`) REFERENCES `POL_ticket`(`id_ticket`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER //

-- Trigger pour supprimer les réponses associées lorsqu'un ticket est supprimé
CREATE TRIGGER delete_reponses_on_ticket_delete
AFTER DELETE ON `POL_ticket`
FOR EACH ROW
BEGIN
  DELETE FROM `POL_reponse_ticket` WHERE `ticket_id` = OLD.id_ticket;
END //

DELIMITER ;
