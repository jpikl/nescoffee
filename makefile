###############################################################################
# Configuration
###############################################################################

VERSION=0.5.0
RELEASE_FILE=cfxnes-$(VERSION).zip
DEPLOY_DIR=../cfxnes-heroku
BACKUP_DIR=~/Dropbox/Backup/projects
BACKUP_FILE=cfxnes.zip
TEMP_DIR=temp

###############################################################################
# Help
###############################################################################

help:
	@echo "Make targets:"
	@echo ""
	@echo "  npm_install  Install npm packages"
	@echo "  npm_check    Check for npm updates"
	@echo "  npm_update   Update npm packages"
	@echo ""
	@echo "  lib          Build library"
	@echo "  lib_dbg      Build library (debug version)"
	@echo "  app          Build application"
	@echo ""
	@echo "  backup       Backup project files"
	@echo "  version      Update version in package.json"
	@echo "  deploy       Deploy application to heroku git repo"
	@echo "  release      Create release ZIP"
	@echo "  tag          Tag current version in git"
	@echo ""
	@echo "  lint         Run linter"
	@echo "  test         Run tests"
	@echo ""
	@echo "  clean        Delete generated files"
	@echo "  clean_all    Delete generated files and downloaded npm packages"

###############################################################################
# NPM
###############################################################################

.PHONY: npm_install npm_check npm_update

npm_install:
	cd core && npm install
	cd lib && npm install
	cd app && npm install

npm_check:
	cd core && ncu
	cd lib && ncu
	cd app && ncu

npm_update:
	cd core && ncu -a
	cd lib && ncu -a
	cd app && ncu -a

###############################################################################
# Build
###############################################################################

.PHONY: lib lib_dbg app

lib:
	cd lib && gulp build

lib_dbg:
	cd lib && gulp build -d

app:
	cd app && gulp build


###############################################################################
# Release
###############################################################################

.PHONY: backup version deploy release tag

backup: clean
	zip -r $(BACKUP_FILE) . -x ".git/*" -x "*/node_modules/*"
	mv $(BACKUP_FILE) $(BACKUP_DIR)

version:
	cd core && npm version $(VERSION); true
	cd lib && npm version $(VERSION); true
	cd app && npm version $(VERSION); true

deploy: clean lib app
	mkdir -p $(DEPLOY_DIR)
	rm -rf ./$(DEPLOY_DIR)/{node_modules,static,*.js,package.json}
	cd app/dist && cp -r . ../../$(DEPLOY_DIR)
	cp app/package.json $(DEPLOY_DIR)
	cd $(DEPLOY_DIR) && npm install --production

release: clean lib_dbg lib app
	mkdir $(TEMP_DIR)
	cp lib/dist/* $(TEMP_DIR)
	cp -r app/dist $(TEMP_DIR)/app
	cp app/package.json $(TEMP_DIR)/app
	cd $(TEMP_DIR) && zip -r ../$(RELEASE_FILE) .

tag:
	git tag -a v$(VERSION) -m "Version $(VERSION)"

###############################################################################
# Test
###############################################################################

.PHONY: lint test

lint:
	cd core && gulp lint
	cd lib && gulp lint
	cd app && gulp lint

test:
	cd core && gulp test
	cd lib && gulp test

###############################################################################
# Clean
###############################################################################

.PHONY: clean clean_all

clean:
	rm -f ./$(BACKUP_FILE)
	rm -f ./$(RELEASE_FILE)
	rm -rf ./$(TEMP_DIR)
	rm -rf ./lib/dist
	rm -rf ./app/dist

clean_all: clean
	rm -rf ./core/node_modules
	rm -rf ./lib/node_modules
	rm -rf ./app/node_modules
