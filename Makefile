setup: install db-prepare

install:
	bin/setup

db-prepare:
	bin/rails db:reset

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

production-build:
	bundle install
	bundle exec rails db:migrate
	bundle exec rails db:seed
	bundle exec rails assets:precompile
	bundle exec rails assets:clean

production-start:
	bundle exec rails server

.PHONY: test
