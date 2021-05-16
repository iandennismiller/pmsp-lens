# Recurrent
# 2020-11-02

all:
	@echo OK

# training

train-dt-100-pmsp:
	mkdir -p \
		../../var/weights/pmsp-recurrent-dt-100-seed-1
	time /opt/Lens-linux/Bin/alens.sh scripts/train-study-3-replication.tcl

train-dt-100-dilution-1:
	mkdir -p \
		../../var/weights/cogsci-recurrent-dt-100-dilution-1-seed-1 \
		../../var/results/cogsci-recurrent-dt-100-dilution-1-seed-1
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 /opt/Lens-linux/Bin/alens.sh scripts/train-cogsci-dt-100-dilution-n.tcl

train-dt-100-dilution-2:
	mkdir -p \
		../../var/weights/cogsci-recurrent-dt-100-dilution-2-seed-1 \
		../../var/results/cogsci-recurrent-dt-100-dilution-2-seed-1
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 /opt/Lens-linux/Bin/alens.sh scripts/train-cogsci-dt-100-dilution-n.tcl

train-dt-100-dilution-3:
	mkdir -p \
		../../var/weights/cogsci-recurrent-dt-100-dilution-3-seed-1 \
		../../var/results/cogsci-recurrent-dt-100-dilution-3-seed-1
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=3 /opt/Lens-linux/Bin/alens.sh scripts/train-cogsci-dt-100-dilution-n.tcl

# accuracy (only if not produced during training)

accuracy-pmsp:
	-rm ../../var/results/pmsp-recurrent-dt-100-seed-1/accuracy.tsv
	time /opt/Lens-linux/Bin/alens.sh scripts/accuracy-dt-100.tcl

accuracy-anchors-dilution-1:
	-rm ../../var/results/cogsci-recurrent-dt-100-dilution-1-seed-1/accuracy-anchors.tsv
	time /opt/Lens-linux/Bin/alens.sh scripts/drafts/accuracy-cogsci-dt-100-dilution-1.tcl

accuracy-anchors-dilution-2:
	-rm ../../var/results/cogsci-recurrent-dt-100-dilution-2-seed-1/accuracy-anchors.tsv
	time /opt/Lens-linux/Bin/alens.sh scripts/drafts/accuracy-cogsci-dt-100-dilution-2.tcl

accuracy-anchors-dilution-3:
	-rm ../../var/results/cogsci-recurrent-dt-100-dilution-3-seed-1/accuracy-anchors.tsv
	time /opt/Lens-linux/Bin/alens.sh scripts/drafts/accuracy-cogsci-dt-100-dilution-3.tcl

# activations: anchors

activations-anchors-pmsp:
	rm -f \
		../../var/results/pmsp-recurrent-dt-100-seed-1/activations-anchors-hidden.txt \
		../../var/results/pmsp-recurrent-dt-100-seed-1/activations-anchors-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/activations-anchors-dt-100-pmsp.tcl

activations-anchors-dilution-1:
	rm -f \
		../../var/results/cogsci-recurrent-dt-100-dilution-1-seed-1/activations-anchors-hidden.txt \
		../../var/results/cogsci-recurrent-dt-100-dilution-1-seed-1/activations-anchors-output.txt
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 /opt/Lens-linux/Bin/alens.sh scripts/activations-anchors-dt-100-dilution-n.tcl

activations-anchors-dilution-2:
	-rm \
		../../var/results/cogsci-recurrent-dt-100-dilution-2-seed-1/activations-anchors-hidden.txt \
		../../var/results/cogsci-recurrent-dt-100-dilution-2-seed-1/activations-anchors-output.txt
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 /opt/Lens-linux/Bin/alens.sh scripts/activations-anchors-dt-100-dilution-n.tcl

activations-anchors-dilution-3:
	rm -f \
		../../var/results/cogsci-recurrent-dt-100-dilution-3-seed-1/activations-anchors-hidden.txt \
		../../var/results/cogsci-recurrent-dt-100-dilution-3-seed-1/activations-anchors-output.txt
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=3 /opt/Lens-linux/Bin/alens.sh scripts/activations-anchors-dt-100-dilution-n.tcl

# activations: probes

activations-probes-pmsp:
	rm -f \
		../../var/results/pmsp-recurrent-dt-100-seed-1/activations-probes-hidden.txt \
		../../var/results/pmsp-recurrent-dt-100-seed-1/activations-probes-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/activations-probes-dt-100-pmsp.tcl

activations-probes-dilution-1:
	rm -f \
		../../var/results/cogsci-recurrent-dt-100-dilution-1-seed-1/activations-probes-hidden.txt \
		../../var/results/cogsci-recurrent-dt-100-dilution-1-seed-1/activations-probes-output.txt
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 /opt/Lens-linux/Bin/alens.sh scripts/activations-probes-dt-100-dilution-n.tcl

activations-probes-dilution-2:
	rm -f \
		../../var/results/cogsci-recurrent-dt-100-dilution-2-seed-1/activations-probes-hidden.txt \
		../../var/results/cogsci-recurrent-dt-100-dilution-2-seed-1/activations-probes-output.txt
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 /opt/Lens-linux/Bin/alens.sh scripts/activations-probes-dt-100-dilution-n.tcl

activations-probes-dilution-3:
	rm -f \
		../../var/results/cogsci-recurrent-dt-100-dilution-3-seed-1/activations-probes-hidden.txt \
		../../var/results/cogsci-recurrent-dt-100-dilution-3-seed-1/activations-probes-output.txt
	PMSP_RANDOM_SEED=1 PMSP_DILUTION=3 /opt/Lens-linux/Bin/alens.sh scripts/activations-probes-dt-100-dilution-n.tcl

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

# activations-fig18:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/activations-fig18.tcl

# train-10-ticks-dt-1:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/train-10-ticks-dt-1.tcl

# pmsp-study-3-replication:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/train-study-3-replication.tcl

# activations-fig18-dt-100:
# 	time /opt/Lens-linux/Bin/alens.sh scripts/activations-fig18-dt-100.tcl
