# Frequency Dilution
# 2020-01-11

all:
	@echo OK

requirements:
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

.PHONY: all requirements lens
