FROM debian:latest AS flutter-build

# Install flutter dependencies
RUN apt-get update && \
    apt-get install -y curl git wget zip unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 && \
    apt-get clean
# Fix tar calling
ENV TAR_OPTIONS=--no-same-owner

# Install flutter
RUN git clone -b 3.24.3 --depth 1 https://github.com/flutter/flutter.git /usr/local/flutter && \
    cd /usr/local/flutter && \
    /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Get flutter packages
WORKDIR /usr/local/flutter-app
COPY ../.. /usr/local/flutter-app
RUN flutter pub get && \
    flutter --version

# Build web app
RUN /usr/local/flutter/bin/flutter build web -t ./lib/main.dart --release

###
FROM nginx:1.19.0
WORKDIR /var/www/html
COPY ./ci/docker/nginx.conf /etc/nginx/nginx.conf
# COPY ./ci/docker/entrypoint.sh /docker-entrypoint.d
# RUN chmod +x /docker-entrypoint.d/entrypoint.sh
COPY --from=flutter-build --chown=www-data /usr/local/flutter-app/build/web .