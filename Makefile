build:
	docker compose build block_explorer

requirements.txt:
	pip-compile

start:
	docker compose up block_explorer