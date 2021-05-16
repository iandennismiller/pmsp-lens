# Recurrent
# 2020-11-02

all:
	@echo OK

train-pmsp-debug:
	time /opt/Lens-linux/Bin/alens.sh scripts/train-pmsp-debug.tcl

train-pmsp:
	time /opt/Lens-linux/Bin/alens.sh scripts/train-pmsp.tcl

train-jepg2017:
	echo time /opt/Lens-linux/Bin/alens.sh scripts/train-jepg2017.tcl

train-cogsci2020:
	time /opt/Lens-linux/Bin/alens.sh scripts/train-cogsci2020.tcl

experiment:
	time /opt/Lens-linux/Bin/alens.sh scripts/experiment.tcl

activations-fig18:
	time /opt/Lens-linux/Bin/alens.sh scripts/activations-fig18.tcl

train-10-ticks-dt-1:
	time /opt/Lens-linux/Bin/alens.sh scripts/train-10-ticks-dt-1.tcl

pmsp-study-3-replication:
	time /opt/Lens-linux/Bin/alens.sh scripts/train-study-3-replication.tcl

activations-fig18-dt-100:
	time /opt/Lens-linux/Bin/alens.sh scripts/activations-fig18-dt-100.tcl

# training

train-dt-100-pmsp:
	time /opt/Lens-linux/Bin/alens.sh scripts/train-study-3-replication.tcl

train-dt-100-dilution-1:
	time /opt/Lens-linux/Bin/alens.sh scripts/pmsp-recurrent-dt-100-dilution-1.tcl

train-dt-100-dilution-2:
	time /opt/Lens-linux/Bin/alens.sh scripts/pmsp-recurrent-dt-100-dilution-2.tcl

train-dt-100-dilution-3:
	time /opt/Lens-linux/Bin/alens.sh scripts/pmsp-recurrent-dt-100-dilution-3.tcl

# accuracy

accuracy-pmsp:
	-rm var/results/pmsp-recurrent-dt-100-seed-1/accuracy.tsv
	time /opt/Lens-linux/Bin/alens.sh scripts/accuracy-dt-100.tcl

accuracy-anchors-dilution-1:
	-rm var/results/jepg-2017-recurrent-dt-100-dilution-1-seed-1/accuracy-anchors.tsv
	time /opt/Lens-linux/Bin/alens.sh scripts/accuracy-cogsci-dt-100-dilution-1.tcl

accuracy-anchors-dilution-2:
	-rm var/results/jepg-2017-recurrent-dt-100-dilution-2-seed-1/accuracy-anchors.tsv
	time /opt/Lens-linux/Bin/alens.sh scripts/accuracy-cogsci-dt-100-dilution-2.tcl

accuracy-anchors-dilution-3:
	-rm var/results/jepg-2017-recurrent-dt-100-dilution-3-seed-1/accuracy-anchors.tsv
	time /opt/Lens-linux/Bin/alens.sh scripts/accuracy-cogsci-dt-100-dilution-3.tcl

# activations: anchors

activations-anchors-pmsp:
	-rm \
		var/results/pmsp-recurrent-dt-100-seed-1/activations-anchors-hidden.txt \
		var/results/pmsp-recurrent-dt-100-seed-1/activations-anchors-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/anchors-activations-dt-100-pmsp.tcl

activations-anchors-dilution-1:
	-rm \
		var/results/jepg-2017-recurrent-dt-100-dilution-1-seed-1/activations-anchors-hidden.txt \
		var/results/jepg-2017-recurrent-dt-100-dilution-1-seed-1/activations-anchors-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/activations-fig18-dt-100-dilution-1.tcl

activations-anchors-dilution-2:
	-rm \
		var/results/jepg-2017-recurrent-dt-100-dilution-2-seed-1/activations-anchors-hidden.txt \
		var/results/jepg-2017-recurrent-dt-100-dilution-2-seed-1/activations-anchors-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/activations-fig18-dt-100-dilution-2.tcl

activations-anchors-dilution-3:
	-rm \
		var/results/jepg-2017-recurrent-dt-100-dilution-3-seed-1/activations-anchors-hidden.txt \
		var/results/jepg-2017-recurrent-dt-100-dilution-3-seed-1/activations-anchors-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/activations-fig18-dt-100-dilution-3.tcl

# activations: probes

activations-probes-pmsp:
	-rm \
		var/results/pmsp-recurrent-dt-100-seed-1/activations-probes-hidden.txt \
		var/results/pmsp-recurrent-dt-100-seed-1/activations-probes-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/probe-activations-dt-100-pmsp.tcl

activations-probes-dilution-1:
	-rm \
		var/results/jepg-2017-recurrent-dt-100-dilution-1-seed-1/activations-probes-hidden.txt \
		var/results/jepg-2017-recurrent-dt-100-dilution-1-seed-1/activations-probes-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/probe-activations-dt-100-dilution-1.tcl

activations-probes-dilution-2:
	-rm \
		var/results/jepg-2017-recurrent-dt-100-dilution-2-seed-1/activations-probes-hidden.txt \
		var/results/jepg-2017-recurrent-dt-100-dilution-2-seed-1/activations-probes-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/probe-activations-dt-100-dilution-2.tcl

activations-probes-dilution-3:
	-rm \
		var/results/jepg-2017-recurrent-dt-100-dilution-3-seed-1/activations-probes-hidden.txt \
		var/results/jepg-2017-recurrent-dt-100-dilution-3-seed-1/activations-probes-output.txt
	time /opt/Lens-linux/Bin/alens.sh scripts/probe-activations-dt-100-dilution-3.tcl
