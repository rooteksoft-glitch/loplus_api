# Utiliser l'image officielle Dart
FROM dart:stable

# Créer un répertoire de travail
WORKDIR /app

# Copier les fichiers du projet
COPY . .

# Récupérer les dépendances
RUN dart pub get

# Exposer le port utilisé par Render
EXPOSE 8080

# Commande de démarrage
CMD ["dart", "run", "bin/server.dart", "--port=8080"]
