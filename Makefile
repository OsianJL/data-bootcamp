PYTHON_VERSION ?= 3.12.3

.PHONY: setup install lab nb fmt lint freeze kernel

setup:
	# Instala Python con pyenv si no existe y deja local la versión
	pyenv install -s $(PYTHON_VERSION)
	pyenv local $(PYTHON_VERSION)
	# Prepara direnv
	echo 'export PYTHON_VERSION=$(PYTHON_VERSION)' > .envrc
	echo 'if ! command -v python &>/dev/null; then exit 1; fi' >> .envrc
	echo 'if [ ! -d .venv ]; then python -m venv .venv; fi' >> .envrc
	echo 'source .venv/bin/activate' >> .envrc
	direnv allow
	# Actualiza pip y wheel
	. .venv/bin/activate && python -m pip install --upgrade pip wheel

install:
	. .venv/bin/activate && pip install -r requirements.txt

lab:
	. .venv/bin/activate && jupyter lab

nb:
	. .venv/bin/activate && jupyter notebook

freeze:
	. .venv/bin/activate && pip freeze --all > requirements_locked.txt

kernel:
	. .venv/bin/activate && python -m ipykernel install --user --name py312-data-bootcamp --display-name "Python 3.12 — Data Bootcamp"

fmt:
	# Espacio para formateo (añadir black/ruff si lo deseas más adelante)
	@echo "Pendiente: añadir black/ruff si procede"

lint:
	@echo "Pendiente: añadir ruff flake8, etc."
