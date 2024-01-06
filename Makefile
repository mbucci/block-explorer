build:
	docker compose build block_explorer

requirements:
	pip-compile

start:
	docker compose up block_explorer

ci: pytest

pytest:
	docker compose run --entrypoint 'pytest -vv' block_explorer