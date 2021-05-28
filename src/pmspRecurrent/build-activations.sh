#!/bin/bash

INPUT_PATH=../../var/results
RESULT_PATH=../../var/results/activations

function activations_to_csv() {
	cat $RESULT_PATH/cogsci-activations-anchors-hidden-dilution-1-seed-1.csv \
		$RESULT_PATH/cogsci-activations-anchors-hidden-dilution-2-seed-1.csv \
		$RESULT_PATH/cogsci-activations-anchors-hidden-dilution-3-seed-1.csv \
		$RESULT_PATH/cogsci-activations-probes-hidden-dilution-1-seed-1.csv \
		$RESULT_PATH/cogsci-activations-probes-hidden-dilution-2-seed-1.csv \
		$RESULT_PATH/cogsci-activations-probes-hidden-dilution-3-seed-1.csv > \
		$RESULT_PATH/cogsci-activations-hidden-seed-1.csv

	cat $RESULT_PATH/cogsci-activations-anchors-output-dilution-1-seed-1.csv \
		$RESULT_PATH/cogsci-activations-anchors-output-dilution-2-seed-1.csv \
		$RESULT_PATH/cogsci-activations-anchors-output-dilution-3-seed-1.csv \
        $RESULT_PATH/cogsci-activations-probes-output-dilution-1-seed-1.csv \
		$RESULT_PATH/cogsci-activations-probes-output-dilution-2-seed-1.csv \
		$RESULT_PATH/cogsci-activations-probes-output-dilution-3-seed-1.csv > \
        $RESULT_PATH/cogsci-activations-output-seed-1.csv
}

function hidden_activations_to_csv() {
    SEED=$1
    DILUTION_LEVEL=$2

	./transform.py hidden_activations \
		--seed $SEED \
		--dilution_level $DILUTION_LEVEL \
		--infile $INPUT_PATH/cogsci-recurrent-dt-100-dilution-$DILUTION_LEVEL-seed-$SEED/activations-anchors-hidden.txt > \
		$RESULT_PATH/cogsci-activations-anchors-hidden-dilution-$DILUTION_LEVEL-seed-$SEED.csv

	./transform.py hidden_activations \
		--seed $SEED \
		--dilution_level $DILUTION_LEVEL \
		--infile $INPUT_PATH/cogsci-recurrent-dt-100-dilution-$DILUTION_LEVEL-seed-$SEED/activations-probes-hidden.txt > \
		$RESULT_PATH/cogsci-activations-probes-hidden-dilution-$DILUTION_LEVEL-seed-$SEED.csv
}

function output_activations_to_csv() {
    SEED=$1
    DILUTION_LEVEL=$2

	./transform.py output_activations \
		--seed $SEED \
		--dilution_level $DILUTION_LEVEL \
		--infile $INPUT_PATH/cogsci-recurrent-dt-100-dilution-$DILUTION_LEVEL-seed-$SEED/activations-anchors-output.txt > \
		$RESULT_PATH/cogsci-activations-anchors-output-dilution-$DILUTION_LEVEL-seed-$SEED.csv

	./transform.py output_activations \
		--seed $SEED \
		--dilution_level $DILUTION_LEVEL \
		--infile $INPUT_PATH/cogsci-recurrent-dt-100-dilution-$DILUTION_LEVEL-seed-$SEED/activations-probes-output.txt > \
		$RESULT_PATH/cogsci-activations-probes-output-dilution-$DILUTION_LEVEL-seed-$SEED.csv
}

function main() {
    hidden_activations_to_csv 1 1
    hidden_activations_to_csv 1 2
    hidden_activations_to_csv 1 3

    output_activations_to_csv 1 1
    output_activations_to_csv 1 2
    output_activations_to_csv 1 3

    activations_to_csv
}

# main

activations_to_csv
