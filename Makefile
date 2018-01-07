include make-compose.mk
include make-ansible.mk

rebuild-styles:
	cd assets/ && \
	yarn install && \
	yarn deploy && \
	cd ../

ansible-development-setup:
	mkdir -p tmp
	touch tmp/ansible-vault-password
	ansible-playbook ansible/development.yml -i ansible/development -vv -K

compile:
	mix compile

install:
	mix deps.get

test:
	mix test

test-coverage-html:
	mix coveralls.html

lint:
	mix credo

clean:
	rm -rf _build
	rm -rf deps
	rm -rf .elixir_ls
	rm -rf assets/node_modules
	rm -rf priv/static/*
	rm -rf cover
	rm -rf tmp/battle_asserts

get-last-changes:
	 git fetch upstream
	 git checkout master
	 git merge upstream/master

upload_asserts:
	 mix issues.fetch
	 mix issues.generate
	 mix issues.upload

upload_langs:
	 mix upload_langs

release:
	MIX_ENV=prod mix edeliver upgrade production --verbose --env=prod

migrate-prod:
	MIX_ENV=prod mix edeliver migrate production

.PHONY: test
