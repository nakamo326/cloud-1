#!/bin/bash

instance_id=`terraform -chdir=../terraform output -raw ec2_instance_id`

if [ -z "$instance_id" ]; then
  echo "No IP Address retrieved."
  exit 1
fi

if [ `uname` == "Darwin" ]; then
  sed -i "" "/${instance_id}/d" hosts
else
  sed -i "/${instance_id}/d" hosts
fi