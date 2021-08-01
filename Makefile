# Frequency Dilution
# 2020-01-11

all:
	@echo OK

requirements-docker:
	mkdir -p ~/.lens-storage
	-cd ~/.lens-storage && \
		git clone https://github.com/iandennismiller/pmsp-lens.git
	pip install 'git+https://projects.sisrlab.com/cap-lab/pmsp-torch#subdirectory=src'

lens:
	docker run -d --rm \
		--name lens \
		-p 5901:5901 \
		-v ~/.lens-storage:/home/lens/storage \
		iandennismiller/lens

example-dilution-2:
	SETTINGS=~/.dilution-deadline-study.ini \
		python3 bin/create-example-file.py \
		create_examples \
		--dilution 2

example-dilution-3:
	SETTINGS=~/.dilution-deadline-study.ini \
		python3 bin/create-example-file.py \
		create_examples \
		--dilution 3

requirements-python:
	pip install click jsfsdb

.PHONY: all requirements lens
