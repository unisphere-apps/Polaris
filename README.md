# Installation

## Étape 1 : Installer Tomcat

1. **Téléchargez et dézippez le fichier Tomcat**  
   Téléchargez le fichier `apache-tomcat-10.1.31-windows-x64.zip` depuis le dépôt du projet ou la source fournie.  
   Extrayez le contenu dans un répertoire sûr, par exemple : `C:\Program Files\Apache\Tomcat`.

2. **Ajout du serveur Tomcat sur Eclipse**  
   Suivez ces étapes pour configurer Tomcat dans Eclipse :
   - Ouvrez Eclipse.
   - Allez dans **Fenêtre > Afficher la vue > Serveurs** (si la vue n'est pas visible).
   - Cliquez avec le bouton droit dans la vue **Servers** et sélectionnez **New > Server**.
   - Choisissez la version de Tomcat correspondante (par exemple, Tomcat 10.x).
   - Pointez vers le répertoire où vous avez dézippé `apache-tomcat-10.1.31-windows-x64.zip`.
   - Cliquez sur **Finish**.

---

## Étape 2 : Ajouter les fichiers `.jar`

- Placez les fichiers `.jar` nécessaires dans le répertoire suivant :  
  `apache-tomcat-10.1.31\lib\`.

Assurez-vous que les bibliothèques sont compatibles avec votre version de Tomcat et les besoins de votre projet.

---

## Étape 3 : Configurer le projet dans Eclipse

1. **Placer les dossiers `build` et `src`**  
   - Copiez les dossiers `build` et `src` dans :  
     `C:\Users\(nom_user)\eclipse-workspace\Polaris`.

2. **Ajout des bibliothèques dans le projet**  
   - Dans Eclipse, faites un clic droit sur le projet Polaris.
   - Sélectionnez **Build Path > Configure Build Path**.
   - Accédez à l'onglet **Libraries**.
   - Cliquez sur **Add External JARs...**.
   - Sélectionnez les fichiers `.jar` ajoutés dans `apache-tomcat-10.1.31\lib`.
   - Cliquez sur **Apply and Close**.

---

## Notes supplémentaires

- Assurez-vous que la version de Java utilisée par Tomcat est correctement configurée dans votre environnement Eclipse.
- Vérifiez que les variables d'environnement comme `JAVA_HOME` sont correctement définies.
