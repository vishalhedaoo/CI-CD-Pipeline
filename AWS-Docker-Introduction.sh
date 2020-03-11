#Reference: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html#install_docker

echo' This document contains
1. Installing the docker.
2. A practical example with Docker.
3. Important docker commands.
'

#1. Launch an instance with the Amazon Linux AMI (by default 'docker' installed one Amazon machines).

#2. Connect to your instance & login to root.
sudo -i

#===============DOCKER INSTALLATION START=================#

#by default 'docker' installed one Amazon machines. check 'docker --version'. If does not exists, install docker on linux machines as follows. If you are practising on ubuntu machines, refer Docker-Practice-1.txt file for installation Docker on ubuntu machines.

#3. update the packages.
sudo yum update -y

#4. Install the docker.
sudo yum install -y docker

echo ' After the installation docker files created in below location.
[root@ip-*.*.*.* ~]# find / -name "docker"
/etc/docker
/etc/rc.d/init.d/docker
/etc/sysconfig/docker
/run/docker
/var/run/docker
/var/lib/docker
/var/lock/subsys/docker
/var/log/docker
/usr/share/bash-completion/docker
/usr/bin/docker
'

#5. start the docker.
sudo service docker start

#6. docker version: docker -v
sudo docker --version

sudo docker --help

#===============DOCKER INSTALLATION END=================#

#===============DOCKER IMAGE & CONTAINER START=================#

#7. Create a docker file & build a docker image.

#7.1. Creating the docker file.

# Task: Create a container with Ubuntu OS, and then install apache on ubuntu container and then deploy a web file (i.e, html file) a hellow world program.
# Here is the docker work-flow.
# "Dockerfile"-----Build the Dockerfile----->"Docker Image"-----Run the docker Image----->"Docker Container" (you can sart, stop, restart, kill, rm the docker containers)
tocuch Dockerfile

echo'
#Docker will donwload the the image ubuntu with the tag 12.04 and create a container with ubuntu OS with the version of 12.04
FROM ubuntu:12.04

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y apache2

# Install apache and write hello world message
RUN echo "Hello World!" > /var/www/index.html

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# apache available on 8080 port.
EXPOSE 80

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
' >> Dockerfile

#7.2. Crete the docker image with the help of docker file "Dockerfile". In the below command, dot (.) represents the Dockerfile presents in the current directory. If docker file name is different, then pass the file name as: docker build -t image-name -f ./customDockerfile .
sudo docker build -t hello-world .

# Image created with the name hello-world. Run the below command to list the images.
sudo docker images

# OR Run the below command to find the docker image with the name hello-world.
sudo docker images --filter reference=hello-world

#Run the image to create the container
sudo docker run -p 80:80 hello-world

echo'
Note:
You can ignore the "Could not reliably determine the servers fully qualified domain name" message.
'

#Copy the public IP from the instance description & paste it on any browser.

#Stop the Docker container by typing Ctrl + c

#===============DOCKER IMAGE & CONTAINER END=================#


#============DOCKER COMMMANDS============#
echo'
1. docker --help
2. docker -v or docker --version or docker version
3. docker images: To get the list of all the local images.
	docker rmi -f <image-name/id> : to remove the image.
4. docker ps: To list the active containers.
	docker ps -a: To list both active & inactive containers.
	docker ps -a -s: To list both active & inactive containers along with the size of the container. -s gives you the container file size.
	docker stop <container-id>: shutdown the container.
	docker rm -f <container-id> Or docker rm -f <container-name/id>: First stop the docker container and then rm.
	docker container logs <container-id>
	docker container kill <container-id>
	docker container rm <container-id>
	docker container run <container-id>
	docker container start <container-id>

5. docker run <image-name>: to run the image & it creates the container.
	docker run -it --name venkat ubuntu : we can give a name to the running container.
	docker ps: see the name in the list of active containers.
	Ex:
	1. docker run -it ubuntu: If the image not in local repo, docker will download from the deocker hub.
	2. Once the container available automatically we will enter into the container i.e., ubuntu.
	3. To exit from the container: exit
	4. To exit from the container: Ctrl - p - Q.
6. docker info
7. docker rm $(docker ps -a -f status=exited -q) : to remove all the container which are exited/not running.
8. docker build -t <image-name> -f <docker file path>
	docker build --help
9. docker run <image-name>
	docker run --help
10. docker pull: to pull the docker images from docker hub.
11. docker login: login creds to docker hub to push our own image from local to hub.
11. docker push <dockerid>/<image-name>: push the local image ti docker hub. Befre push, the local image need to be tagged with docker id. 
	docker tag <image-name> <dockerid>/<image-name>.
12. docker stop <container-id>: shutdown the container.
13. docker kill <container-id>: kills the execution of the contaner comopletely.
14. docker exec: This command is used to access an running container and perform operations inside the container.
	docker exec -it <container-id> bash
15. docker commit <container-id> <new-image-name> or docker commit <container-id> <docker-hub-id>/<new-image-name>: Create the new image from the modified running container.
15. docker export: Save the container as tar file in local machine.
	docker export --output="MyDocker.tar" <container-id>
16. docker import:
	docker import <path/imagetarfile>
'
#============PULL THE IMAGES from Docker hub============#

echo'
ex: Create a new container by install ubuntu OS
'

#Note: You no need to run as sudo user if you have sudo permissions. If you don't have sudo permissions, you can run all the commands as sudo user.

#Ex-1. It will download the image "ubuntu" from Docker hub and install the ubuntu then login to ubuntu.
sudo docker run -it ubuntu 

#Ex-2.1. First Pull the docker images from docker hub
sudo docker pull ubuntu

#Ex-2.2. Now, Run the pulled image 'ubuntu'
sudo docker run -it ubuntu

#Ex-3.1. First Pull the docker images from docker hub
sudo docker pull centos

#Ex-3.2. Now, Run the pulled image 'centos'
sudo docker run -it centos

#see the list of images which are available in your local machine.
sudo docker images

