#!/bin/bash

IMAGE="synthetic_nrois=100000_roiarea=100000\.tif"

EXPERIMENT_NAME="scalability"
DATADIR="/home/ec2-user/work/data/synthetic2"
OUTDIR="./OUT1"
NYXUSDIR="/home/ec2-user/work/nyxus/BUILD1"
ls -s -a $DATADIR

set -e	# exitscript on error
set -x	# display each command

#-- Not erasing previously created results, but adding to it-- 
#
#	rm -r $OUTDIR
#	mkdir -p $OUTDIR
#

$NYXUSDIR/nyxus --useGpu=false --verbosity=4 --features=*ALL* --intDir=$DATADIR/int --segDir=$DATADIR/seg --outDir=$OUTDIR --filePattern=$IMAGE --csvFile=singlecsv --loaderThreads=1 --reduceThreads=1


