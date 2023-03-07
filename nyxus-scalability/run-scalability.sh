#!/bin/bash

EXPERIMENT_NAME="scalability"
DATADIR="/home/ec2-user/work/data/synthetic2"
OUTDIR="./OUT1"
NYXUSDIR="/home/ec2-user/work/nyxus/BUILD1"
ls -s -a $DATADIR

set -e	# exitscript on error
set -x	# display each command

rm -r $OUTDIR
mkdir -p $OUTDIR

$NYXUSDIR/nyxus --useGpu=true --verbosity=3 --features=*ALL* --intDir=$DATADIR/int --segDir=$DATADIR/seg --outDir=$OUTDIR --filePattern=.* --csvFile=singlecsv --loaderThreads=1 --reduceThreads=8


