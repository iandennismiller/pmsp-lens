# Frequency Dilution
# 2020-01-11

all:
	@echo OK

requirements:
	mkdir ~/.lens-storage
	cd ~/.lens-storage && \
		git clone https://github.com/iandennismiller/pmsp-lens.git

lens:
	docker run -d --rm \
		--name lens \
		-p 5901:5901 \
		-v ~/.lens-storage:/home/lens/storage \
		iandennismiller/lens

.PHONY: all requirements lens
