.env:
	touch .env

build: .env
	docker compose build block_explorer

.PHONY: requirements.txt
requirements.txt:
	pip-compile

start: .env
	docker compose up block_explorer

ci: pytest

deploy:
	cd terraform && make deploy

pytest: .env
	docker compose run test
