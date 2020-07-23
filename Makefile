# Frequency Dilution
# 2020-01-11

all:
	@echo OK

test:
	~/lens-linux/Bin/alens.sh src/test.tcl

train:
	~/lens-linux/Bin/alens.sh src/train.tcl

train-seed-2:
	~/lens-linux/Bin/alens.sh src/train-seed-2.tcl

experiment:
	~/lens-linux/Bin/alens.sh src/experiment.tcl

test-frequency:
	~/lens-linux/Bin/alens.sh src/testFrequency/main.tcl

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

products:
	cp R/frequency-dilution/*.html products

.PHONY: all test train train-seed-2 experiment test-frequency requirements lens products
