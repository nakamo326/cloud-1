tf_dir:=../terraform

all:
	echo `terraform -chdir=$(tf_dir) output -raw ec2_ip` >> ./hosts
	./scripts/wait_booting.sh `terraform -chdir=$(tf_dir) output -raw ec2_ip`
	ansible-playbook deploy.yaml

.PHONY: all