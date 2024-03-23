#!/bin/bash

if [ ! -e ./hosts ]; then
  cp ./hosts.tmpl ./hosts
fi

instances=`terraform -chdir=../terraform output -json ec2_instance_id | jq -r '.[]'`

for instance in ${instances}; do
  if grep -q ${instance} ./hosts; then
    continue
  fi

  echo ${instance} >> ./hosts
done