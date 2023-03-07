#!/bin/bash

EXPERIMENT_NAME="nyxus-restricted-RAM"
DATADIR="/home/ec2-user/work/data/synthetic3-for-varying-memory"
OUTDIR="./OUT1"
NYXUSDIR="/home/ec2-user/work/nyxus/BUILD1"

# series 1: ROI area=10K
# FPATT="synthetic_nrois=100000_roiarea=10000\.tif"
FPATT="synthetic_nrois=100000_roiarea=20000\.tif"
# FPATT="synthetic_nrois=100000_roiarea=40000\.tif"
# FPATT="synthetic_nrois=100000_roiarea=60000\.tif"

# series 2: ROI area=100K
# --takes long-- FPATT="synthetic_nrois=100000_roiarea=100000\.tif"

ls -s -a $DATADIR

set -e	# exit script on error
set -x	# display each command

rm -r $OUTDIR
mkdir -p $OUTDIR

#=== Calculate specific feature groups
declare -a arr=(
"30000"
#--- "20000"
#--- "10000"
#--- "5000"
#--- "1000"
)

#=== Check that the feature definition files exist
for i in "${arr[@]}"
do
    echo "$i"
done

#=== Extract features
for i in "${arr[@]}"
do
    start=$(date +%s)
    $NYXUSDIR/nyxus --ramLimit=$i --useGpu=true --verbose=3 --features=*ALL* --intDir=$DATADIR/int --segDir=$DATADIR/seg --outDir=$OUTDIR --filePattern=$FPATT --csvFile=singlecsv --loaderThreads=1 --reduceThreads=8
    end=$(date +%s)
    echo "$FPATT -- $i Mb -- $(($end-$start)) seconds" >> $OUTDIR/timing.txt
done


