#!/bin/bash

if [ ! -e ./hosts ]; then
  cp ./hosts.tmpl ./hosts
fi

echo `terraform -chdir=../terraform output -raw ec2_ip` >> ./hosts
