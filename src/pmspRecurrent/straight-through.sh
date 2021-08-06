#!/bin/bash

function run_one_partition {
    PARITION=$1

    PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 PMSP_PARTITION=$PARITION \
        /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

    PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 PMSP_PARTITION=$PARITION \
        /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

    PMSP_RANDOM_SEED=1 PMSP_DILUTION=3 PMSP_PARTITION=$PARITION \
        /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl
}

run_one_partition 0 &
run_one_partition 1 &
run_one_partition 2 &
