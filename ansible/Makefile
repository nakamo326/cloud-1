tf_dir:=../terraform

all:
	./scripts/add_hosts.sh
	./scripts/wait_booting.sh
	ansible-playbook deploy.yaml

des:
	./scripts/delete_hosts.sh

.PHONY: all des