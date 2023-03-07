#!/bin/bash 

EXPERIMENT_NAME="banchmarking_Pyradiomics"
DATADIR="/home/ec2-user/work/data/mini"
OUTDIR="/home/ec2-user/work/data/OUTPUT-mini"
ls -s -a $DATADIR

#=== Request echoing of each command executed 
set -x

rm -rf $OUTDIR
mkdir -p $OUTDIR

date
start=$(date +%s)

###	pyradiomics ./mini_int_p0_y1_r1_c0.tiff ./mini_seg_p0_y1_r1_c0.tiff -o ./results_pyradiomics.csv -f csv

files=(/home/ec2-user/work/data/tissuenet/convert_int/*)

for fpath in ${files[@]}
do
  fn=${fpath##*/}
  pyradiomics "/home/ec2-user/work/data/tissuenet/convert_int/${fn}" "/home/ec2-user/work/data/tissuenet/convert_seg/${fn}" -o "/home/ec2-user/work/benchmarks/pyradiomics/OUTPUT-pyradiomics/${fn}.csv" --format csv --jobs 8 

done

end=$(date +%s)
echo "Experiment: $EXPERIMENT_NAME Elapsed Time: $(($end-$start)) seconds"
echo "Experiment: $EXPERIMENT_NAME Elapsed Time: $(($end-$start)) seconds" > timing_$EXPERIMENT_NAME.txt
date

