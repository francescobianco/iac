
.PHONY: proxmox

proxmox:
	@tofu -chdir=proxmox apply -var-file=../secrets.tfvars
