#!/bin/bash

# インスタンスIDをセットします。コマンドライン引数から取得するか、直接値を入力してください。
INSTANCE_ID="$1"

if [ -z "$INSTANCE_ID" ]; then
  echo "インスタンスIDが必要です。"
  exit 1
fi

echo "インスタンス $INSTANCE_ID の起動を待機しています..."

# インスタンスがrunning状態になるまで待機
while true; do
  STATUS=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[].Instances[].State.Name' --output text)

  if [ "$STATUS" == "running" ]; then
    echo "インスタンスが起動しました。"
    break
  else
    echo "インスタンスがまだ起動していません。"
  fi

  sleep 5
done

echo "Session Manager経由での接続が可能になるまで待機しています..."

# Session Managerで接続可能になるまで待機
while true; do
  # ssm describe-instance-informationコマンドを使用して、インスタンスがSession Managerで管理されているかチェックします。
  SSM_STATUS=$(aws ssm describe-instance-information --query 'InstanceInformationList[].InstanceId' --output text | grep $INSTANCE_ID)

  if [ ! -z "$SSM_STATUS" ]; then
    echo "Session Manager経由で接続可能です。"
    break
  else
    echo "Session Manager経由での接続がまだ可能ではありません。"
  fi

  sleep 5
done

echo "インスタンス $INSTANCE_ID にSession Manager経由で接続できる状態です。"
