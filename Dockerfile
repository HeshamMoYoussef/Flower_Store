# Multi-stage build: compiles the Flutter web bundle, then serves it via Nginx.
# Usage:
#   docker build -t flower-store .
#   docker run --rm -p 8080:80 flower-store
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .
RUN flutter build web --release

FROM nginx:alpine AS runtime

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
