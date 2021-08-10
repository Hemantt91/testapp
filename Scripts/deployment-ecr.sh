#!/usr/bin/env bash

Account=777471403090
Region="ap-south-1"
Repository_Name="insurance-non-prod-iona"
ec2_port=80
container_port=80

ecr_login() {
        aws ecr get-login-password --region $Region | docker login --username AWS --password-stdin "$Account.dkr.ecr.$Region.amazonaws.com"
# aws ecr get-login --no-include-email --region $Region
}

pull_image() {
        docker pull $Account.dkr.ecr.$Region.amazonaws.com/$Repository_Name:latest
}

stop_container(){
        container_id=`docker ps |awk '{print $1}'|tail -1`
        docker stop $container_id
}

start_container(){
        image_id=`docker images $Account.dkr.ecr.$Region.amazonaws.com/$Repository_Name:latest |awk '{print $3}'|tail -1`
        docker run -itd -p $ec2_port:$container_port $image_id
}

validation() {
        echo -e '\x1dclose\x0d' | telnet localhost $container_port | tee
        if [[ $? -eq 0 ]];
        then
                echo "Telnet is successful."
                curl  http://localhost:80
                Responce=`curl -iLs http://localhost:80|grep HTTP |awk '{print $2}'`
                if [[ $Responce -eq 200 ]];
                then
                        echo "Deployment is Successsful."
                fi
        else
                echo "Deployment is Unsuccessful."
        fi
}

ecr_login
pull_image
stop_container
start_container
validation
