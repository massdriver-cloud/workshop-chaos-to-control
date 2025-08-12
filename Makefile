.PHONY: all publish-bundles publish-artifacts clean lambda-image

# Default target - runs all publishing tasks
all: publish-artifacts publish-bundles clean

# Publish all bundles by running 'mass bundle publish' in each bundle subdirectory
publish-bundles:
	@echo "Publishing all bundles..."
	@for bundle in bundles/*/; do \
		if [ -d "$$bundle" ]; then \
			echo "Publishing bundle in $$bundle"; \
			cd "$$bundle" && mass bundle publish && cd - > /dev/null; \
		fi; \
	done
	@echo "All bundles published successfully!"

# Publish all artifact definitions by running 'mass definition publish' for each file
publish-artifacts:
	@echo "Publishing all artifact definitions..."
	@for artifact in artifact-definitions/*; do \
		if [ -f "$$artifact" ]; then \
			echo "Publishing artifact definition: $$artifact"; \
			mass definition publish -f "$$artifact"; \
		fi; \
	done
	@echo "All artifact definitions published successfully!"

clean:
	@echo "Cleaning up schema-*.json files..."
	@find bundles/ -name "schema-*.json" -type f -delete 2>/dev/null || true
	@echo "Clean completed!"

# Help target to show available commands
help:
	@echo "Available targets:"
	@echo "  all               - Publish all bundles and artifact definitions (default)"
	@echo "  publish-bundles   - Publish all bundles in the bundles/ directory"
	@echo "  publish-artifacts - Publish all artifact definitions in artifact-definitions/"
	@echo "  clean             - Remove schema-*.json build files" 	
	@echo "  help              - Show this help message" 

lambda-image:
	cd bundles/aws-ctc-lambda/src && docker build -t massdrivercloud/aws-ddb-collab-demo:latest . && docker push massdrivercloud/aws-ddb-collab-demo:latest
		