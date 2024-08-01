
deploy:
ifndef resource
	$(error "Missing 'resource' argument, type: make deploy resource=PATH")
endif
	@echo "Deploying $(resource)..."
	@cat $(resource)/.deploy.sh | bash .deploy.sh $(resource)
