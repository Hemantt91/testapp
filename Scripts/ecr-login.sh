#!/bin/bash

Account=777471403090
Region="ap-south-1"

ecr_login() {
	aws ecr get-login-password --region $Region | docker login --username AWS --password-stdin "$Account.dkr.ecr.$Region.amazonaws.com"
# aws ecr get-login --no-include-email --region $Region
}


ecr_login
