#!/bin/bash

VM_IP=$1
PORT=22

if [ -z "$VM_IP" ]
then
  echo "Usage: $0 {vm_ip}"
  exit 1
fi

until nc -zv $VM_IP $PORT
do
  echo "Waiting for VM $VM_IP to start SSH..."
  sleep 5
done

echo "VM $VM_IP is now accepting SSH connections."
