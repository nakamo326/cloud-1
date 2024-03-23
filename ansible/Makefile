tf_dir:=../terraform

all:
	./scripts/add_hosts.sh
	./scripts/wait_booting.sh
	# WSL環境でansible-playbook実行時にエラーが発生するため、一時的に環境変数を設定
	LC_ALL=en_US.UTF-8 ansible-playbook deploy.yaml

des:
	./scripts/delete_hosts.sh

.PHONY: all des