#!/bin/bash

Account=777471403090
Region="ap-south-1"
Repository_Name="insurance-non-prod-iona"

pull_image() {
	docker pull $Account.dkr.ecr.$Region.amazonaws.com/$Repository_Name:latest
}

pull_image