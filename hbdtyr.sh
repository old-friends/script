#!/bin/bash
# This is the simple bash script
NAME=webserver-1
PORT=8089
IMAGE_NAME=oldfriends/web-server

# Let's run a container and expose the ports accordingly
docker run --name ${NAME} -it -d -p ${PORT}:80 -d --privileged=true ${IMAGE_NAME}:latest bash -c "/usr/sbin/init" > /dev/null 2&>1

# Let's enable some variable and then will check result on browser
NODE_PORT=$(docker inspect webserver-1 | grep -i "HostPort" | head -1 | awk -F ':' '{print $2}' | sed 's/ "//g' | sed 's/"//g' )
NODE_IP=$(ifconfig eth1 | grep -i "inet" | grep -v "inet6" | awk '{print $2}')

# Echo the result which need to be apply on browser
echo -e "#######################################"
echo -e "Please run the below URL in any browser"
echo -e "#######################################"
echo -e "http://${NODE_IP}:${NODE_PORT}"
