FROM alpine:3.15

#vire
#EXPOSE 443
RUN	apk update && apk upgrade && apk add --no-cache \
        nginx \
        openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365\
        -out /etc/nginx/ssl/sameye.pem \
        -keyout /etc/nginx/ssl/sameye.key \
        -subj "/C=FR/ST=Paris/O=42School/CN=sameye.com/"\
		-addext "subjectAltName=DNS:mydomain.com"\
		-newkey rsa:2048

RUN chown -R nginx:nginx /var/www;

RUN mkdir -p /run/nginx
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

# Start nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
