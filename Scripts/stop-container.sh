#!/bin/bash


stop_container(){
	container_id=`docker ps |awk '{print $1}'|tail -1`
	docker stop $container_id
}


stop_container