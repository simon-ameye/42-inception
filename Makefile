#to be executed with sudo make

#docker container run -it alpine:3.13 /bin/sh
#docker exec -it nginx sh

#reset all
#docker stop $(docker ps -qa)
#docker rm $(docker ps -qa)
#docker rmi -f $(docker images -qa)
#docker volume rm $(docker volume ls -q)
#docker network rm $(docker network ls -q)

NAME = inception

all: prune start


#stop the container
stop:
	@ docker-compose -f srcs/docker-compose.yml down

#stop and delete volumes
clean: stop
	@ rm -rf /home/sameye/data/

#remove unused containers
prune: clean
	@ docker-compose -f srcs/docker-compose.yml down --rmi all -v \
	&& docker system prune -f

#build using file
start:
	mkdir -p /home/sameye/data \
	&& mkdir /home/sameye/data/wordpress \
	&& mkdir /home/sameye/data/mariadb \
	&& docker-compose -f srcs/docker-compose.yml up --build

run:
	docker-compose -f srcs/docker-compose.yml up

.PHONY: linux stop clean prune start all
