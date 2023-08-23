FROM debian:latest AS build-env

ARG TOKEN
RUN apt-get update
RUN apt-get install -y curl file git unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev
RUN apt-get clean
RUN git clone https://github.com/flutter/flutter.git --branch 3.10.2 --single-branch /usr/local/flutter
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"
RUN flutter doctor -v
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter pub get
RUN flutter build web --release

FROM nginx:1.23-alpine
COPY --from=build-env /app/nginx.conf /etc/nginx/nginx.conf
COPY --from=build-env /app/build/web /var/www
