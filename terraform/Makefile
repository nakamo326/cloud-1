all:
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

ssh:
	ssh -i ./cloud-1-key-pair.pem -o StrictHostKeyChecking=no \
	ubuntu@$(shell terraform output -raw ec2_ip)

.PHONY: all destroy ssh
