#!/bin/bash

if [ ! -e ./hosts ]; then
  cp ./hosts.tmpl ./hosts
fi

ip_address=`terraform -chdir=../terraform output -raw ec2_ip`

if grep -q ${ip_address} ./hosts; then
  exit 0
fi

echo ${ip_address} >> ./hosts
