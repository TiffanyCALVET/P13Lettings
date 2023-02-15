## Résumé

Site web d'Orange County Lettings

## Développement local

### Prérequis

- Compte GitHub avec accès en lecture à ce repository
- Git CLI
- SQLite3 CLI
- Interpréteur Python, version 3.6 ou supérieure

Dans le reste de la documentation sur le développement local, il est supposé que la commande `python` de votre OS shell exécute l'interpréteur Python ci-dessus (à moins qu'un environnement virtuel ne soit activé).

### macOS / Linux

#### Cloner le repository

- `cd /path/to/put/project/in`
- `git clone https://github.com/OpenClassrooms-Student-Center/Python-OC-Lettings-FR.git`

#### Créer l'environnement virtuel

- `cd /path/to/Python-OC-Lettings-FR`
- `python -m venv venv`
- `apt-get install python3-venv` (Si l'étape précédente comporte des erreurs avec un paquet non trouvé sur Ubuntu)
- Activer l'environnement `source venv/bin/activate`
- Confirmer que la commande `python` exécute l'interpréteur Python dans l'environnement virtuel
`which python`
- Confirmer que la version de l'interpréteur Python est la version 3.6 ou supérieure `python --version`
- Confirmer que la commande `pip` exécute l'exécutable pip dans l'environnement virtuel, `which pip`
- Pour désactiver l'environnement, `deactivate`

#### Exécuter le site

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `pip install --requirement requirements.txt`
- `python manage.py runserver`
- Aller sur `http://localhost:8000` dans un navigateur.
- Confirmer que le site fonctionne et qu'il est possible de naviguer (vous devriez voir plusieurs profils et locations).

#### Linting

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `flake8`

#### Tests unitaires

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `pytest`

#### Base de données

- `cd /path/to/Python-OC-Lettings-FR`
- Ouvrir une session shell `sqlite3`
- Se connecter à la base de données `.open oc-lettings-site.sqlite3`
- Afficher les tables dans la base de données `.tables`
- Afficher les colonnes dans le tableau des profils, `pragma table_info(Python-OC-Lettings-FR_profile);`
- Lancer une requête sur la table des profils, `select user_id, favorite_city from
  Python-OC-Lettings-FR_profile where favorite_city like 'B%';`
- `.quit` pour quitter

#### Panel d'administration

- Aller sur `http://localhost:8000/admin`
- Connectez-vous avec l'utilisateur `admin`, mot de passe `Abc1234!`

### Windows

Utilisation de PowerShell, comme ci-dessus sauf :

- Pour activer l'environnement virtuel, `.\venv\Scripts\Activate.ps1` 
- Remplacer `which <my-command>` par `(Get-Command <my-command>).Path`


## Docker

Télécharger et installer [Docker](https://docs.docker.com/get-docker/)

Commande :
- création d'image : `docker build -t <image-name> `
- lancement : `docker run --publish 8080:8080  <image-name>`

Vous pouvez accéder à l'application dans un navigateur via http://127.0.0.1:8080/


## Développement 

### Prérequis

Pour effectuer le déploiment vous devez vous connecter ou vous créer un compte
aux applications sivantes :
- [GitHub](https://github.com/)
- [CircleCI](https://circleci.com)
- [Docker](https://www.docker.com)
-  [Heroku](https://www.heroku.com)
- [Sentry](https://sentry.io/welcome/)

### Description

Le déploiement de l'application est automatisé par le pipeline CircleCi.

Tous push sur Github effectué sur la branche main relance le pipeline.

Si les Tests et les linting sont réussis, alors le pipeline crée une image Docker 
du projet et le dépose sur le DockerHub. Si cette étape est validée alors l'application est
déployée sur Heroku.

### CircleCI

Se connecter à son compte via GitHub. Récupérer le votre projet.
Les instructions de commande se retourve dans le fichier .circleci/config.yml .

Dans Settings Project/Environnement Variables configurez les données suivantes :
- DOCKER_LOGIN 
- DOCKER_PASSWORD
- DOCKER_REPO 
- HEROKU_API_KEY 
- HEROKU_APP_NAME 
- SENTRY_DSN


### Docker

Créer un répertoire sur DockerHub pour accueillir l'image du pipeline de CircleCi.


### Heroku

Connectez-vous à votre compte Héroku. 
Créer une nouvelle app. 

Dans l'onglet Deploy vous connecter avec votre compte GitHub et choisir votre projet.

Dans l'onglet Ressource activé les Eco Dynos (web gunicorn) ne pas ajouter Add-ons 
DATABASE.

Dans l'onglet Settings/Config Vars, ajoutez la variable SENTRY_DSN et sa valeur.


### Sentry

Connectez-vous à Sentry et créer un projet avec Django.

Il vous faudra :
- renseignez la clef DSN dans : le fichier .env du projet, dans votre pipeline CircleCI et dans Heroku. 
Elle se trouve dans l'onglet Settings/Project/Client Keys (DSN).
- Il vous faudra générer une erreur et une route. Vous serez guider lors de la création de votre projet.