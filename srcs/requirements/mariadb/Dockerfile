FROM 			alpine:3.15

#install mariadb-client just to demonstrate connection
RUN 			apk update && apk upgrade && apk add --no-cache \
				mariadb											\
				mariadb-common									\
				mariadb-client

COPY 			./tools/conf.sh 			/tmp/conf.sh


ENTRYPOINT 		[ "sh", "/tmp/conf.sh" ]