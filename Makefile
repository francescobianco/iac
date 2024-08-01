
deploy:
ifndef resource
	$(error "Missing 'resource' argument, type: make deploy resource=PATH")
endif
	@cat $(resource)/.deploy.sh | bash .deploy.sh $(resource)
