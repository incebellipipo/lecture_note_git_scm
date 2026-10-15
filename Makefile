# The notebooks in notebooks/ are the course. There is no generated copy of
# them: edit the notebook, and that is the whole edit.
#
# If jupyter lives in a virtualenv, either activate it or pass the path:
#   make test JUPYTER=~/ros_ws/venv/bin/jupyter

JUPYTER ?= jupyter

.PHONY: help test serve

help:           ## list the targets
	@grep -E '^[a-z]+:.*##' $(MAKEFILE_LIST) | sed 's/:.*##/\t/'

test:           ## run every notebook top to bottom, in a throwaway HOME
	@tmp=$$(mktemp -d); \
	HOME=$$tmp git config --global user.name "Test Runner"; \
	HOME=$$tmp git config --global user.email "test@example.com"; \
	HOME=$$tmp git config --global init.defaultBranch main; \
	HOME=$$tmp $(JUPYTER) nbconvert --to notebook --execute \
	  --ExecutePreprocessor.timeout=180 --output-dir "$$tmp/out" \
	  notebooks/[0-9][0-9]-*.ipynb && echo "all notebooks ran clean"; \
	status=$$?; rm -rf "$$tmp"; exit $$status

serve:          ## preview the website at http://localhost:4000/lecture_notes_git/
	docker compose up
