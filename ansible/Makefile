tf_dir:=../terraform

all:
	./scripts/add_hosts.sh
	./scripts/wait_booting.sh `terraform -chdir=$(tf_dir) output -raw ec2_ip`
	ansible-playbook deploy.yaml

des:
	./scripts/delete_hosts.sh

.PHONY: all des