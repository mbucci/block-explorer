build:
	docker compose build block_explorer

compile:
	pip-compile

start: build
	docker compose up block_explorer