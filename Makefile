all:
	$(MAKE) -C ./terraform all
	$(MAKE) -C ./ansible all

des:
	$(MAKE) -C ./terraform des

ssh:
	$(MAKE) -C ./terraform ssh

.PHONY: all des ssh