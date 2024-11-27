-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 27, 2024 at 12:34 AM
-- Server version: 8.0.30
-- PHP Version: 7.4.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `unisphere`
--

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `id_article` int NOT NULL,
  `date` date NOT NULL,
  `titre` varchar(30) DEFAULT NULL,
  `contenu` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `pol_categorie`
--

CREATE TABLE `pol_categorie` (
  `id_categorie` int NOT NULL,
  `nom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `pol_categorie`
--

INSERT INTO `pol_categorie` (`id_categorie`, `nom`) VALUES
(1, 'Support Technique'),
(2, 'Bug'),
(3, 'Demande de Fonctionnalité'),
(4, 'Question Générale'),
(5, 'Autre');

-- --------------------------------------------------------

--
-- Table structure for table `pol_reponse_ticket`
--

CREATE TABLE `pol_reponse_ticket` (
  `id_reponse` int NOT NULL,
  `date_reponse` datetime NOT NULL,
  `contenu` text NOT NULL,
  `user_id` int NOT NULL,
  `ticket_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `pol_ticket`
--

CREATE TABLE `pol_ticket` (
  `id_ticket` int NOT NULL,
  `date_creation` datetime NOT NULL,
  `sujet` varchar(255) NOT NULL,
  `description` text,
  `statut` enum('ouvert','fermé') DEFAULT 'ouvert',
  `user_id` int NOT NULL,
  `categorie_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `pol_ticket`
--

INSERT INTO `pol_ticket` (`id_ticket`, `date_creation`, `sujet`, `description`, `statut`, `user_id`, `categorie_id`) VALUES
(2, '2024-11-25 16:29:35', 'Erreur système', 'Un message d’erreur s’affiche lorsque j’essaie de sauvegarder mes modifications.', 'ouvert', 1, 3),
(3, '2024-11-25 16:29:35', 'Problème de paiement', 'Le paiement par carte bancaire échoue sur la page de commande.', 'ouvert', 1, 4),
(4, '2024-11-25 16:29:35', 'Demande d’assistance', 'Je souhaite être aidé pour configurer mon profil utilisateur.', 'ouvert', 1, 1),
(5, '2024-11-25 16:29:35', 'Suggestion d’amélioration', 'Serait-il possible d’ajouter un mode sombre à l’application ?', 'ouvert', 1, 5),
(6, '2024-11-25 16:29:35', 'Bug d’affichage', 'Certains textes ne s’affichent pas correctement sur mobile.', 'ouvert', 1, 3),
(9, '2024-11-27 00:11:12', 'sa marches pa', 'lol', 'ouvert', 1, 1);

--
-- Triggers `pol_ticket`
--
DELIMITER $$
CREATE TRIGGER `delete_reponses_on_ticket_delete` AFTER DELETE ON `pol_ticket` FOR EACH ROW BEGIN
  DELETE FROM `POL_reponse_ticket` WHERE `ticket_id` = OLD.id_ticket;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id_role` int NOT NULL,
  `role_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id_role`, `role_name`) VALUES
(1, 'etudiant'),
(2, 'admin'),
(3, 'super_admin');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) DEFAULT NULL,
  `etablissement` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mdp` varchar(255) DEFAULT NULL,
  `role_id` int DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nom`, `prenom`, `etablissement`, `email`, `mdp`, `role_id`) VALUES
(1, 'Guerrand', 'Anthony', 'iris', 'anthony.guerrand92@gmail.com', 'root', 1),
(2, 'Guerrand', 'Anthony', 'iris', 'fqf@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$cGNGeE82WUliUUN3eThLRA$03cD9fO0Dh8S0YawD15hlW4qppdKu0MIXU+cN5e/qfQ', 1);

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `before_user_delete` BEFORE DELETE ON `user` FOR EACH ROW BEGIN
  -- Mettre le champ `user_id` à NULL pour les articles de l'utilisateur supprimé
  UPDATE `article`
  SET `user_id` = NULL
  WHERE `user_id` = OLD.id_user;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `check_email_before_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
  DECLARE email_count INT;

  -- Vérifier si l'email existe déjà dans la table `user`
  SELECT COUNT(*)
  INTO email_count
  FROM `user`
  WHERE `email` = NEW.email;

  -- Si l'email existe déjà, lever une exception
  IF email_count > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cet email est déjà utilisé.';
  END IF;
  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_user_logs` AFTER DELETE ON `user` FOR EACH ROW BEGIN
  -- Supprimer les logs associés à l'utilisateur supprimé
  DELETE FROM user_log
  WHERE user_id = OLD.id_user;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_log`
--

CREATE TABLE `user_log` (
  `id_log` int NOT NULL,
  `date` datetime NOT NULL,
  `action` varchar(30) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `user_log`
--

INSERT INTO `user_log` (`id_log`, `date`, `action`, `description`, `ip_address`, `user_agent`, `user_id`) VALUES
(1, '2024-11-25 16:25:27', 'inscription', 'Nouvelle inscription pour l\'utilisateur: anthony.guerrand92@gmail.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', NULL),
(2, '2024-11-25 16:25:31', 'connexion', '', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 1),
(3, '2024-11-26 15:10:55', 'connexion', '', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 1),
(4, '2024-11-26 15:11:07', 'deconnexion', '', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 1),
(5, '2024-11-26 15:41:56', 'inscription', 'Nouvelle inscription pour l\'utilisateur: fqf@gmail.com', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', NULL),
(6, '2024-11-26 15:42:01', 'connexion', '', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id_article`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `pol_categorie`
--
ALTER TABLE `pol_categorie`
  ADD PRIMARY KEY (`id_categorie`);

--
-- Indexes for table `pol_reponse_ticket`
--
ALTER TABLE `pol_reponse_ticket`
  ADD PRIMARY KEY (`id_reponse`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ticket_id` (`ticket_id`);

--
-- Indexes for table `pol_ticket`
--
ALTER TABLE `pol_ticket`
  ADD PRIMARY KEY (`id_ticket`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `categorie_id` (`categorie_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id_role`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_log`
--
ALTER TABLE `user_log`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `id_article` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pol_categorie`
--
ALTER TABLE `pol_categorie`
  MODIFY `id_categorie` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pol_reponse_ticket`
--
ALTER TABLE `pol_reponse_ticket`
  MODIFY `id_reponse` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pol_ticket`
--
ALTER TABLE `pol_ticket`
  MODIFY `id_ticket` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id_role` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_log`
--
ALTER TABLE `user_log`
  MODIFY `id_log` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `article_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `pol_reponse_ticket`
--
ALTER TABLE `pol_reponse_ticket`
  ADD CONSTRAINT `pol_reponse_ticket_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `pol_reponse_ticket_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `pol_ticket` (`id_ticket`) ON DELETE CASCADE;

--
-- Constraints for table `pol_ticket`
--
ALTER TABLE `pol_ticket`
  ADD CONSTRAINT `pol_ticket_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `pol_ticket_ibfk_2` FOREIGN KEY (`categorie_id`) REFERENCES `pol_categorie` (`id_categorie`) ON DELETE SET NULL;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id_role`);

--
-- Constraints for table `user_log`
--
ALTER TABLE `user_log`
  ADD CONSTRAINT `user_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
