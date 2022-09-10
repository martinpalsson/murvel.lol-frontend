FROM nginx:1.23.1-alpine
RUN apk add --no-cache bash

# configuration
COPY ./nginx.conf /etc/nginx/nginx.conf
# content

COPY ./dist /usr/share/nginx/html
