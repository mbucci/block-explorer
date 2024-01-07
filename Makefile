.env:
	touch .env

build: .env
	docker compose build block_explorer

requirements:
	pip-compile

start: .env
	docker compose up block_explorer

ci: pytest

pytest: .env
	docker compose run test