.PHONY: clean
clean:
	rm -rf .pytest_cache htmlcov .coverage requirements.txt

.PHONY: run
run:
	poetry run uvicorn api.app.main:app --host 0.0.0.0 --port 9000 --reload

.PHONY: test
test:
ifndef COVERAGE
	poetry run python -m pytest
else
	poetry run coverage run -m pytest
	poetry run coverage html
	@echo "=============================================================================="
	@echo "||                                                                          ||"
	@echo "||                View HTML report http://localhost:8000                    ||"
	@echo "||                                                                          ||"
	@echo "=============================================================================="
	poetry run python -m http.server --directory htmlcov
endif

.PHONY: requirements
requirements:
	poetry export --without-hashes --format=requirements.txt > requirements.txt

.PHONY: deploy
deploy: clean requirements
ifndef PROD
	vercel
else
	vercel --prod
endif

.PHONY: fmt
fmt:
	poetry run autoflake --ignore-init-module-imports --remove-all-unused-imports --verbose --remove-unused-variables -r -i app/* tests/*
	poetry run isort .
	poetry run black .