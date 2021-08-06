#!/bin/bash

rm -f /tmp/2021-08-06-activations.tgz

tar cfz /tmp/2021-08-06-activations.tgz \
    var/net/cogsci-recurrent-dt-100-dilution-1-seed-1-partition-0-straight-through/results \
    var/net/cogsci-recurrent-dt-100-dilution-1-seed-1-partition-1-straight-through/results \
    var/net/cogsci-recurrent-dt-100-dilution-1-seed-1-partition-2-straight-through/results \
    var/net/cogsci-recurrent-dt-100-dilution-2-seed-1-partition-0-straight-through/results \
    var/net/cogsci-recurrent-dt-100-dilution-2-seed-1-partition-1-straight-through/results \
    var/net/cogsci-recurrent-dt-100-dilution-2-seed-1-partition-2-straight-through/results \
    var/net/cogsci-recurrent-dt-100-dilution-3-seed-1-partition-0-straight-through/results \
    var/net/cogsci-recurrent-dt-100-dilution-3-seed-1-partition-1-straight-through/results \
    var/net/cogsci-recurrent-dt-100-dilution-3-seed-1-partition-2-straight-through/results
