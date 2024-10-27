#!/bin/bash

ip_address=`terraform -chdir=../terraform output -raw ec2_ip`

if [ -z "$ip_address" ]; then
  echo "No IP Address retrieved."
  exit 1
fi

if [ `uname` == "Darwin" ]; then
  sed -i "" "/${ip_address}/d" hosts
else
  sed -i "/${ip_address}/d" hosts
fi