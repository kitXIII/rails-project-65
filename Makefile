setup: install db-prepare create-admin db-seed-demo-data copy-env

setup-clean: install db-prepare

install:
	bin/setup

db-prepare:
	bin/rails db:reset

db-seed-demo-data:
	bin/rails demo:create categories=5 users=5 bulletins=30

copy-env:
	cp -n .env.example .env
	$(info !!! Please fill the .env variables !!!)

create-admin:
	bin/rails supervisor:create

start:
	bin/dev

console:
	bin/rails console

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

lint-fix:
	bundle exec rubocop app -A

test:
	yarn run build
	yarn run build:css
	NODE_ENV=test bin/rails test

.PHONY: test
