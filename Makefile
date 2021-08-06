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

examples:
	bin/create-for-partition.sh 0
	bin/create-for-partition.sh 1
	bin/create-for-partition.sh 2
	SETTINGS=~/.dilution-deadline-study.ini \
		bin/create-example-file.py create_probes --frequency 1.0 > \
		usr/examples/probes-new-2021-08-04.ex

requirements-python:
	pip install click jsfsdb

.PHONY: all requirements lens examples
