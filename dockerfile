FROM dart:stable AS build
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get
COPY . .
RUN dart compile exe bin/server.dart -o bin/server

FROM dart:stable AS runtime
WORKDIR /app
COPY --from=build /app/bin/server /app/bin/server
COPY --from=build /app/images /app/images  
EXPOSE 8080

# Commande de démarrage
CMD ["dart", "run", "bin/server.dart", "--port=8080"]
