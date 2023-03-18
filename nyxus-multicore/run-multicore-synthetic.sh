#!/bin/bash

EXPERIMENT_NAME="nyxus-multicore-synthetic"

# EC2
# DATADIR="/home/ec2-user/work/data/synthetic2"
# NYXUSDIR="/home/ec2-user/work/nyxus/BUILD1"
# MPB
DATADIR="/Users/natfugl/work/axle/data/synthetic1"
NYXUSDIR="/Users/natfugl/work/axle/nyxus-004/BUILD1"

OUTDIR="./OUT1"

# series 1: ROI area=1K
FPATT="synthetic_nrois=1000_roiarea=10000\.tif"
# FPATT="synthetic_nrois=100000_roiarea=10000\.tif"
# FPATT="synthetic_nrois=100000_roiarea=20000\.tif"
# FPATT="synthetic_nrois=100000_roiarea=40000\.tif"
# FPATT="synthetic_nrois=100000_roiarea=60000\.tif"

ls -s -a $DATADIR

set -e	# exit script on error
set -x	# display each command

rm -r $OUTDIR
mkdir -p $OUTDIR

#=== Calculate specific feature groups
declare -a arr=(
"1"
"2"
#-- "3"
"4"
#-- "5"
"6"
#-- "7"
"8"
#-- "9"
"10"
#-- "11"
"12"
#-- "13"
"14"
#-- "15"
"16"
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
    $NYXUSDIR/nyxus --useGpu=true --verbose=3 --features=*ALL* --intDir=$DATADIR/int --segDir=$DATADIR/seg --outDir=$OUTDIR --filePattern=$FPATT --csvFile=singlecsv --loaderThreads=1 --reduceThreads=$i
    end=$(date +%s)

    # Register time
    echo "$FPATT -- $i threads -- $(($end-$start)) seconds" >> $OUTDIR/timing-$EXPERIMENT_NAME.txt

    # Save detailed timing
    #	mv $OUTDIR/*nyxustiming*.csv  "$OUTDIR/detailedtiming_$EXPERIMENT_NAME_$FPATT_$i_threads.csv"
done


