import cv2		# ROI labels manipulation
import numpy as np
import os		# iterating directory files
import pandas as pd	# saving results as CSV
import datetime
import subprocess

# Command line example (all 2D features): 
# ./MitkCLGlobalImageFeatures --image ~/work/data/mini_dicom/intensity/p0_y1_r1_c1.dcm --mask ~/work/data/mini_dicom/segmentation/p0_y1_r1_c1.dcm -cooc2 -ngtd -id -gldz -glsz -rl -ngld -loci -foh -fon -fo --output features_2d.csv
# ./MitkCLGlobalImageFeatures --image ~/work/data/mini_dicom/intensity/p0_y1_r1_c1.dcm --mask ~/work/data/mini_dicom/segmentation/p0_y1_r1_c1.dcm -cooc2 -ngtd -id -gldz -glsz -rl -ngld -loci -foh -fon -fo -vol -volden -ivoh -cur --output features_3d.csv

# ---Timing---
t_a = datetime.datetime.now()

# ---Settings---
#   features = "-ngtd -gldz -glsz -rl -ngld -loci -foh -fon -fo -id" # all 2D features
#   features = "-ngtd -gldz -glsz -rl -ngld" # texture features
features = "-loci -fon -fo" # intensity features
int_dir = '/home/ec2-user/work/data/mini/convert_int/'
seg_dir = '/home/ec2-user/work/data/mini/convert_seg/'
out_dir = '/home/ec2-user/work/benchmarks/mitk/OUTPUT1/'
mitk_exe = '/home/ec2-user/work/mitk/MITK-github/build/MITK-build/bin/MitkCLGlobalImageFeatures'

iFiles = os.listdir(int_dir)
sFiles = os.listdir(seg_dir)
iFiles.sort()
sFiles.sort()
if iFiles != sFiles :
    print ('Error: intensity and segment file lists don not match\n')
    print ('Intensities: {0}\n'.format(iFiles))
    print ('Segmentation: {0}\n'.format(sFiles))

# iterate over files in that directory
for i in range(0, len(sFiles)) :    # for fn in os.listdir(seg_dir):
    fnInt = iFiles [i]
    fnSeg = sFiles[i]
    f = os.path.join (seg_dir, fnSeg)

    # checking if it is a file
    if os.path.isfile(f):
        print (f'file {f}')
        # Prepare the destination
        feResult = []
        f_csv = os.path.join (out_dir, fnSeg) + '.csv'
        # Read the image
        img = cv2.imread(f, 2)
        # iterate labels
        print('LABELS', end=' ', flush=True)
        unkLabels = np.unique(img)
        for label in unkLabels:
            if (label == 0):
                continue
            print (f'{label} ', end='', flush=True)

            # Prepare a single-ROI image a-la Imea
            '''
            threshed = cv2.inRange (img, int(label), int(label))
            bw = np.array (threshed, dtype='bool')
            #--debug-- print(bw)
            #---    fvals = imea.shape_measurements_2d(bw)
            #---    feResult.append(fvals)
            '''

            # Command line example: ./MitkCLGlobalImageFeatures --image ~/work/data/tissuenet_dicom/intensity/p0_y1_r1_c1.dcm --mask ~/work/data/tissuenet_dicom/segmentation/p0_y1_r1_c1.dcm --all-features --output features
            t_now = datetime.datetime.now()
            print('[{0}/{1} elapsed {5} s]--- about to process {2}/{3}/label{4} ---\n'.format(i, len(sFiles), fnInt, fnSeg, label, (t_now-t_a).seconds), flush=True) 
            exitCode = subprocess.run ([mitk_exe, "--image", os.path.join(seg_dir, fnInt), "--mask", os.path.join(seg_dir, fnSeg), features, "--output", os.path.join(out_dir, "mitk_features.csv"), "--label", str(label) ], check=True)
            print('--- exit code = {0} ---\n'.format(exitCode))

        print ('DONE', flush=True)

'''
        # Output
        feResult = pd.concat(feResult)
        feResult.to_csv(f_csv)
'''

# Timing
t_b = datetime.datetime.now()
t_elap = t_b - t_a
print (t_elap.seconds, 'seconds')
print (t_elap.microseconds, 'microseconds')

