#!/bin/bash

PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 PMSP_PARTITION=0 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 PMSP_PARTITION=0 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

PMSP_RANDOM_SEED=1 PMSP_DILUTION=3 PMSP_PARTITION=0 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 PMSP_PARTITION=1 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 PMSP_PARTITION=1 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

PMSP_RANDOM_SEED=1 PMSP_DILUTION=3 PMSP_PARTITION=1 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

PMSP_RANDOM_SEED=1 PMSP_DILUTION=1 PMSP_PARTITION=2 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

PMSP_RANDOM_SEED=1 PMSP_DILUTION=2 PMSP_PARTITION=2 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl

PMSP_RANDOM_SEED=1 PMSP_DILUTION=3 PMSP_PARTITION=2 \
    /opt/Lens-linux/Bin/alens.sh scripts/straight-through.tcl
