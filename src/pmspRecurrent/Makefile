# Recurrent
# 2020-11-02

all:
	@echo OK

bundle:
	-rm /tmp/2021-07-10-pmsp-activations.tgz
	tar cfz /tmp/2021-07-10-pmsp-activations.tgz \
		../../var/net/pmsp-recurrent-dt-100-seed-1/results \
		../../var/net/pmsp-recurrent-dt-100-seed-2/results

search-parameter-the-frequency:
	# rm -f ../../var/results/search-parameter-the-frequency.txt
	/opt/Lens-linux/Bin/alens.sh scripts/search-parameter-the-frequency.tcl

# extract unit activations and produce CSV
activations-to-csv: 
	./build-activations.sh

test-activations-to-csv:
	./transform.py hidden_activations \
		--seed 1 \
		--dilution_level 1 \
		--infile ../../var/results/cogsci-recurrent-dt-100-dilution-1-seed-1/activations-anchors-hidden.txt

orthography-activations-csv:
	./transform.py orthography_phonology \
		--word_file ~/Work/pmsp-torch/src/pmsp/data/plaut_dataset_collapsed.csv \
		--freq_file ~/Work/pmsp-torch/src/pmsp/data/word-frequencies.csv \
		--out_csv ../../usr/data/pmsp-orthography-phonology.csv

	./transform.py orthography_phonology \
		--word_file ~/Work/pmsp-torch/src/pmsp/data/anchors_new3.csv \
		--freq_file ~/Work/pmsp-torch/src/pmsp/data/word-frequencies.csv \
		--out_csv ../../usr/data/anchors-orthography-phonology.csv

	./transform.py orthography_phonology \
		--word_file ~/Work/pmsp-torch/src/pmsp/data/probes_new.csv \
		--freq_file ~/Work/pmsp-torch/src/pmsp/data/word-frequencies.csv \
		--out_csv ../../usr/data/probes-orthography-phonology.csv

# training

train-pmsp-feedforward:
	PMSP_RANDOM_SEED=1 /opt/Lens-linux/Bin/alens.sh scripts/train-pmsp-feedforward.tcl

train-dt-100-pmsp:
	PMSP_RANDOM_SEED=1 /opt/Lens-linux/Bin/alens.sh scripts/train-study-3-replication.tcl

train-dt-100-dilution-1:
	PMSP_RANDOM_SEED=2 PMSP_DILUTION=1 /opt/Lens-linux/Bin/alens.sh scripts/train-cogsci-dt-100-dilution-n.tcl

train-dt-100-dilution-2:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 /opt/Lens-linux/Bin/alens.sh scripts/train-cogsci-dt-100-dilution-n.tcl

train-dt-100-dilution-3:
	PMSP_RANDOM_SEED=2 PMSP_DILUTION=3 /opt/Lens-linux/Bin/alens.sh scripts/train-cogsci-dt-100-dilution-n.tcl

train-straight-through:
	./scripts/straight-through.sh

# accuracy (only if not produced during training)

accuracy-pmsp:
	PMSP_RANDOM_SEED=1 /opt/Lens-linux/Bin/alens.sh scripts/accuracy-pmsp-dt-100.tcl

accuracy-anchors-dilution-1:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 /opt/Lens-linux/Bin/alens.sh scripts/accuracy-cogsci-dt-100-dilution-n.tcl

accuracy-anchors-dilution-2:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 /opt/Lens-linux/Bin/alens.sh scripts/accuracy-cogsci-dt-100-dilution-n.tcl

accuracy-anchors-dilution-3:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=3 /opt/Lens-linux/Bin/alens.sh scripts/accuracy-cogsci-dt-100-dilution-n.tcl

# activations: anchors

activations-anchors-pmsp:
	PMSP_RANDOM_SEED=2 /opt/Lens-linux/Bin/alens.sh scripts/activations-anchors-dt-100-pmsp.tcl

activations-anchors-dilution-1:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 /opt/Lens-linux/Bin/alens.sh scripts/activations-anchors-dt-100-dilutio1-n.tcl

activations-anchors-dilution-2:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 /opt/Lens-linux/Bin/alens.sh scripts/activations-anchors-dt-100-dilution-n.tcl

activations-anchors-dilution-3:
	PMSP_RANDOM_SEED=2 PMSP_DILUTION=3 /opt/Lens-linux/Bin/alens.sh scripts/activations-anchors-dt-100-dilution-n.tcl

# activations: probes

activations-probes-pmsp:
	PMSP_RANDOM_SEED=2 /opt/Lens-linux/Bin/alens.sh scripts/activations-probes-dt-100-pmsp.tcl

activations-probes-dilution-1:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 /opt/Lens-linux/Bin/alens.sh scripts/activations-probes-dt-100-dilution-n.tcl

activations-probes-dilution-2:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 /opt/Lens-linux/Bin/alens.sh scripts/activations-probes-dt-100-dilution-n.tcl

activations-probes-dilution-3:
	PMSP_RANDOM_SEED=2 PMSP_DILUTION=3 /opt/Lens-linux/Bin/alens.sh scripts/activations-probes-dt-100-dilution-n.tcl

# train-pmsp-debug:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/train-pmsp-debug.tcl

# train-pmsp:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/train-pmsp.tcl

# train-jepg2017:
# 	echo time /opt/Lens-linux/Bin/alens.sh scripts/train-jepg2017.tcl

# train-cogsci2020:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/train-cogsci2020.tcl

# experiment:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/experiment.tcl

activations-fig18:
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 PMSP_PARTITION=1 \
		~/lens-linux/Bin/alens.sh scripts/activations-fig18-dt-100.tcl

# train-10-ticks-dt-1:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/train-10-ticks-dt-1.tcl

# pmsp-study-3-replication:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/train-study-3-replication.tcl

# activations-fig18-dt-100:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/activations-fig18-dt-100.tcl
