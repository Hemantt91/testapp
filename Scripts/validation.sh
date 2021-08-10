#!/bin/bash

Account=777471403090
Region="ap-south-1"
Repository_Name="insurance-non-prod-iona"
ec2_port=80
container_port=80

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

validation