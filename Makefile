all:
	$(MAKE) -C ./terraform all
	echo `terraform -chdir=./terraform output -raw ec2_ip` >> ./ansible/hosts
	./scripts/wait_booting.sh `terraform -chdir=./terraform output -raw ec2_ip`
	$(MAKE) -C ./ansible all

des:
	$(MAKE) -C ./terraform des

ssh:
	$(MAKE) -C ./terraform ssh

.PHONY: all des ssh