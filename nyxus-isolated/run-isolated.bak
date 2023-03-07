#!/bin/bash

EXPERIMENT_NAME="isolated"
DATADIR="/home/ec2-user/work/data/tissuenet"
OUTDIR="./OUT1"
NYXUSDIR="/home/ec2-user/work/nyxus/BUILD1"
ls -s -a $DATADIR

set -e	# exitscript on error
set -x	# display each command

rm -r $OUTDIR
mkdir -p $OUTDIR

#=== Calculate specific feature groups
declare -a arr=(
"cellpro_inten_distr.features"
"cellpro_shape.features"
"cellpro_inten.features"
"cellpro_texture.features"
"cellpro_neighbor.features"
"imea_caliper.features"
"imea_meso.features"
"imea_micro.features"
"imea_shape.features"
"matlab_caliper.features"
"matlab_inten.features"
"matlab_shape.features"
"matlab_texture.features"
"mitk_inten.features"
"mitk_texture.features"
"nist_inten.features"
"nist_shape.features"
"nist_texture.features"
"pyradiomics_inten.features"
"pyradiomics_texture.features"
"radj_inten.features"
"radj_shape.features"
"radj_texture.features"
"wc_inten.features"
"wc_misc.features"
"wc_shape.features"
"wc_texture.features"
)

#=== Check that the feature definition files exist
for i in "${arr[@]}"
do
    ls mock/"$i"
done

#=== Extract features
for i in "${arr[@]}"
do
    start=$(date +%s)
    $NYXUSDIR/nyxus --useGpu=true --verbosity=3 --features=mock/"$i" --intDir=$DATADIR/int --segDir=$DATADIR/seg --outDir=$OUTDIR --filePattern=.* --csvFile=singlecsv --loaderThreads=1 --reduceThreads=8
    end=$(date +%s)
    echo "$i $(($end-$start)) seconds" >> $OUTDIR/timing.txt
done


