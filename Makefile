
apply:
ifndef resource
	$(error "Missing 'resource' argument, type: make attach resource=PATH")
endif
	@echo "Attach resource from '$(resource)' directory"
	@bash .apply.sh $(resource)

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
	@echo "Backup resource from '$(resource)' directory"
	@cat $(resource)/.backup.sh | bash .backup.sh $(resource)

deploy:
ifndef resource
	$(error "Missing 'resource' argument, type: make deploy resource=PATH")
endif
	@echo "Deploy resource from '$(resource)' directory"
	@git add .
	@git commit -am "Deploy resource from '$(resource)' directory" || true
	@git push
	@cat $(resource)/.deploy.sh | bash .exec.sh $(resource)

shell: attach
