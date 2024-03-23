#!/bin/bash

instances=`terraform -chdir=../terraform output -json ec2_instance_id | jq -r '.[]'`

for instance_id in ${instances}; do
  # Session Managerで接続可能になるまで待機
  while true; do
    # ssm describe-instance-informationコマンドを使用して、インスタンスがSession Managerで管理されているかチェックします。
    ssm_status=$(aws ssm describe-instance-information --query 'InstanceInformationList[].InstanceId' --output text | grep $instance_id)

    if [ ! -z "$ssm_status" ]; then
      echo "Session Manager経由で接続可能です。"
      break
    else
      echo "Session Manager経由での接続がまだ可能ではありません。"
    fi

    sleep 5
  done
done


