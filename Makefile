# Frequency Dilution
# 2020-01-11

all:
	@echo OK

test:
	/opt/Lens-linux/Bin/alens.sh src/frequencyDilution/test.tcl

train:
	/opt/Lens-linux/Bin/alens.sh src/frequencyDilution/train.tcl

experiment:
	/opt/Lens-linux/Bin/alens.sh src/experiment.tcl

test-frequency:
	/opt/Lens-linux/Bin/alens.sh src/testFrequency/main.tcl

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
