#!/bin/bash


instances=`terraform -chdir=../terraform output -json ec2_instance_id | jq -r '.[]'`

# delete instance from hosts file
for instance_id in ${instances}; do
  if ! grep -q ${instance_id} hosts; then
    continue
  fi

  if [ `uname` == "Darwin" ]; then
    sed -i "" "/${instance_id}/d" hosts
  else
    sed -i "/${instance_id}/d" hosts
  fi
done