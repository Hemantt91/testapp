#!/bin/bash

Account=777471403090
Region="ap-south-1"
Repository_Name="insurance-non-prod-iona"
ec2_port=80
container_port=80

start_container(){
	image_id=`docker images $Account.dkr.ecr.$Region.amazonaws.com/$Repository_Name:latest |awk '{print $3}'|tail -1`
	docker run -itd -p $ec2_port:$container_port $image_id
}


start_container