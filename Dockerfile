# FROM cirrusci/flutter:stable as flutter_image
FROM nginx:latest

LABEL maintainer="nguyenthevinh297@gmail.com"
LABEL name="vinh"

ARG WEB_RENDERER=auto
ARG BUILD_WEB_PATH="build/web"

WORKDIR /app

COPY ./build/web /app/web

RUN pwd

RUN ls -a

RUN cd /etc/nginx/conf.d

RUN pwd
# RUN flutter clean
# RUN flutter pub get
# RUN flutter gen-l10n

# RUN flutter build web --web-renderer $WEB_RENDERER

# EXPOSE 8080