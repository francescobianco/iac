
attach:
ifndef resource
	$(error "Missing 'resource' argument, type: make attach resource=PATH")
endif
	@echo "Attach resource from '$(resource)' directory"
	@bash .attach.sh $(resource)

backup:
ifndef resource
	$(error "Missing 'resource' argument, type: make backup resource=PATH")
endif
	@echo "Backup $(resource)"
	@cat $(resource)/.backup.sh | bash .exec.sh $(resource)

deploy:
ifndef resource
	$(error "Missing 'resource' argument, type: make deploy resource=PATH")
endif
	@echo "Deploy $(resource)"
	@cat $(resource)/.deploy.sh | bash .exec.sh $(resource)

shell: attach
