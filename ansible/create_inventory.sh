#!/bin/bash

ubuntus=$(aws ec2 describe-instances  \
--filter "Name=tag:class,Values=ubuntu*"  \
--query "Reservations[*].Instances[*].PublicIpAddress"  --output=text)  

echo [ubuntu] > inventory

for i in $ubuntus
do
echo $i >> inventory
done

echo [centos] >> inventory
centos=$(aws ec2 describe-instances  \
--filter "Name=tag:class,Values=centos*"  \
--query "Reservations[*].Instances[*].PublicIpAddress"  --output=text) 
for i in $centos
do
echo $i >> inventory
done

#vars
echo [centos:vars] >>inventory
echo "ansible_ssh_user=ec2-user" >>inventory
echo "ansible_ssh_private_key_file=~/.ssh/inventory_key.pem">>inventory


echo [ubuntu:vars] >>inventory
echo "ansible_ssh_user=ubuntu" >>inventory
echo "ansible_ssh_private_key_file=~/.ssh/inventory_key.pem">>inventory