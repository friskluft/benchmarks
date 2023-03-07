#!/bin/bash

EXPERIMENT_NAME="plain-vanilla-nyxus"
DATADIR="/home/ec2-user/work/data/tissuenet"
OUTDIR="./OUT1"
NYXUSDIR="/home/ec2-user/work/nyxus/BUILD1"
ls -s -a $DATADIR

set -e	# exitscript on error
set -x	# display each command

rm -r $OUTDIR
mkdir -p $OUTDIR

#=== Extract features using GPU

start=$(date +%s)
$NYXUSDIR/nyxus --useGpu=true --verbosity=0 --features=*ALL* --intDir=$DATADIR/int --segDir=$DATADIR/seg --outDir=$OUTDIR --filePattern=.* --csvFile=singlecsv --loaderThreads=1 --reduceThreads=8
end=$(date +%s)
echo "using GPU:  $(($end-$start)) seconds" >> $OUTDIR/timing.txt

#=== ... without GPU

start=$(date +%s)
$NYXUSDIR/nyxus --useGpu=false --verbosity=0 --features=*ALL* --intDir=$DATADIR/int --segDir=$DATADIR/seg --outDir=$OUTDIR --filePattern=.* --csvFile=singlecsv --loaderThreads=1 --reduceThreads=8
end=$(date +%s)
echo "without GPU:  $(($end-$start)) seconds" >> $OUTDIR/timing.txt




