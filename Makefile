all:
	$(MAKE) -C ./terraform all
	$(MAKE) -C ./ansible all

des:
	$(MAKE) -C ./ansible des
	$(MAKE) -C ./terraform des

ssh:
	$(MAKE) -C ./terraform ssh

install_ssm:
	curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/mac_arm64/sessionmanager-bundle.zip" -o "sessionmanager-bundle.zip"
	unzip sessionmanager-bundle.zip
	sudo ./sessionmanager-bundle/install -i /usr/local/sessionmanagerplugin -b /usr/local/bin/session-manager-plugin
	sudo rm -rf ./sessionmanager-bundle
	rm -f ./sessionmanager-bundle.zip

uninstall_ssm:
	sudo rm -rf /usr/local/sessionmanagerplugin
	sudo rm /usr/local/bin/session-manager-plugin

.PHONY: all des ssh install_ssm uninstall_ssm