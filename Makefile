#to be executed with sudo make

#docker container run -it alpine:3.13 /bin/sh
#docker exec -it nginx sh

NAME = inception

all: reset prune reload

#should not be required : host already with right name
linux:
	@ echo "127.0.0.1 sameye.42.fr" >> /etc/hosts

#reset as required in subject
reset:
	-docker stop $(docker ps -qa)
	-docker rm $(docker ps -qa)
	-docker rmi -f $(docker images -qa)
	-docker volume rm $(docker volume ls -q)
	-docker network rm $(docker network ls -q)

#stop the container
stop:
	@ docker-compose -f srcs/docker-compose.yml down

#stop and delete volumes
clean: stop
	@ rm -rf /home/sameye/data/

#remove unused containers
prune: clean
	@ docker system prune -f

#build using file
reload:
	@ mkdir /home/sameye/data/
	@ mkdir /home/sameye/data/wordpress_data/
	@ mkdir /home/sameye/data/mariadb_data/
	@ docker-compose -f srcs/docker-compose.yml up --build

.PHONY: linux stop clean prune reload all