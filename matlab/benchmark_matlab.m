% timestamp 1/2
tic

% itemized timing
tottimeInten = 0;
tottimeShape = 0;
tottimeTexture = 0;
 
% Constants:
ofs = 1;          % GLCM P-matrix offset
 
intDir = '/home/ec2-user/work/data/tissuenet/int' ;
segDir = '/home/ec2-user/work/data/tissuenet/seg' ;
outfilepath = '/home/ec2-user/work/benchmarks/matlab/OUT1/matlab_features_tissuenet.csv';
% d = uigetdir(pwd, 'Select a folder');
ff = fullfile(intDir, '*.tif');
files = dir(ff);
 
nextRow = 1;
OutTable = zeros(1,1);
 
nf = length(files)
for i=1:nf
           f = [intDir '/' files(i).name]
           I = imread (f);
           f = [segDir '/' files(i).name]
           S = imread (f);
          
           nextCol = 1;
          
           %==== Texture

           t1 = datetime; % ~~~itemized time~~~
          
		   % 0 deg
		   glcm = graycomatrix(I,'Offset',[0 ofs]);
		   glcm_dg_0 = graycoprops(glcm,{'all'});
		   % -- save
		   OutTable(nextRow, nextCol) = glcm_dg_0.Contrast;
		   OutTable(nextRow, nextCol+1) = glcm_dg_0.Correlation;
		   OutTable(nextRow, nextCol+2) = glcm_dg_0.Energy;
		   OutTable(nextRow, nextCol+3) = glcm_dg_0.Homogeneity;
		   nextCol = nextCol + 4;
	 
		   % 45 deg
		   glcm = graycomatrix(I,'Offset',[ofs ofs]);
		   glcm_dg_45 = graycoprops(glcm,{'all'});
		  
		   % -- save
		   OutTable(nextRow, nextCol) = glcm_dg_45.Contrast;
		   OutTable(nextRow, nextCol+1) = glcm_dg_45.Correlation;
		   OutTable(nextRow, nextCol+2) = glcm_dg_45.Energy;
		   OutTable(nextRow, nextCol+3) = glcm_dg_45.Homogeneity;
		   nextCol = nextCol + 4;
	 
		   % 90 deg
		   glcm = graycomatrix(I,'Offset',[ofs 0]);
		   glcm_dg_90 = graycoprops(glcm,{'all'});
		   % -- save
		   OutTable(nextRow, nextCol) = glcm_dg_90.Contrast;
		   OutTable(nextRow, nextCol+1) = glcm_dg_90.Correlation;
		   OutTable(nextRow, nextCol+2) = glcm_dg_90.Energy;
		   OutTable(nextRow, nextCol+3) = glcm_dg_90.Homogeneity;
		   nextCol = nextCol + 4;
	 
		   % 135 deg
		   glcm = graycomatrix(I,'Offset',[ofs -ofs]);
		   glcm_dg_135 = graycoprops(glcm,{'all'});
		   % -- save
		   OutTable(nextRow, nextCol) = glcm_dg_135.Contrast;
		   OutTable(nextRow, nextCol+1) = glcm_dg_135.Correlation;
		   OutTable(nextRow, nextCol+2) = glcm_dg_135.Energy;
		   OutTable(nextRow, nextCol+3) = glcm_dg_135.Homogeneity;
		   nextCol = nextCol + 4;

           % ~~~itemized time~~~
           t2 = datetime;
           tottimeTexture = tottimeTexture + etime(datevec(t2) , datevec(t1));
          
           %==== Intensity

           t1 = datetime; % ~~~itemized time~~~
		  
		   % get ahold of the nonzero intensity pixel cloud
		   [Rows, Cols, PixClo] = find(I);
		  
		   % entropy
		   f_entro = entropy(PixClo);
		   OutTable(nextRow, nextCol) = f_entro;
		   nextCol = nextCol + 1;
		  
		   % IQR
		   f_iqr = iqr(double(PixClo));
		   OutTable(nextRow, nextCol) = f_iqr;
		   nextCol = nextCol + 1;       
	 
		   % kurtosis
		   f_kurt = kurtosis(double(PixClo));
		   OutTable(nextRow, nextCol) = f_kurt;
		   nextCol = nextCol + 1;
	 
		   % max
		   f_max = max(PixClo);
		   OutTable(nextRow, nextCol) = f_max;
		   nextCol = nextCol + 1;
		  
		   % mean
		   f_mean = mean(PixClo);
		   OutTable(nextRow, nextCol) = f_mean;
		   nextCol = nextCol + 1;
		  
		   % MAD
		   f_mad = mad(double(PixClo));
		   OutTable(nextRow, nextCol) = f_mad;
		   nextCol = nextCol + 1;
		  
		   % median
		   f_median = median(PixClo);
		   OutTable(nextRow, nextCol) = f_median;
		   nextCol = nextCol + 1;
		  
		   % min
		   f_min = min(PixClo);
		   OutTable(nextRow, nextCol) = f_min;
		   nextCol = nextCol + 1;
	 
		   % mode
		   f_mode = mode(PixClo);
		   OutTable(nextRow, nextCol) = f_mode;
		   nextCol = nextCol + 1;
		  
		   % percentiles
		   f_p1 = prctile (PixClo, 1);
		   f_p25 = prctile (PixClo, 25);
		   f_p75 = prctile (PixClo, 75);
		   f_p90 = prctile (PixClo, 90);
		   f_p99 = prctile (PixClo, 99);
		   OutTable(nextRow, nextCol) = f_p1;
		   OutTable(nextRow, nextCol) = f_p25;
		   OutTable(nextRow, nextCol) = f_p75;
		   OutTable(nextRow, nextCol) = f_p90;
		   OutTable(nextRow, nextCol) = f_p99;
		   nextCol = nextCol + 5;
	 
		   % range
		   f_range = range(PixClo);
		   OutTable(nextRow, nextCol) = f_range;
		   nextCol = nextCol + 1;
	 
		   % RMS
		   f_rms = rms(PixClo);
		   OutTable(nextRow, nextCol) = f_rms;
		   nextCol = nextCol + 1;
		  
		   % skewness
		   f_skew = skewness(double(PixClo));
		   OutTable(nextRow, nextCol) = f_skew;
		   nextCol = nextCol + 1;                  
		  
		   % stddev
		   f_stddev = std(double(PixClo));
		   OutTable(nextRow, nextCol) = f_stddev;
		   nextCol = nextCol + 1;
	 
		   % std error
		   f_stder = std( double(PixClo) ) / sqrt( length( PixClo ));
		   OutTable(nextRow, nextCol) = f_stder;
		   nextCol = nextCol + 1;       
		  
		   % variance
		   f_var = var(double(PixClo));
		   OutTable(nextRow, nextCol) = f_var;
		   nextCol = nextCol + 1;

           % ~~~itemized time~~~
           t2 = datetime;
           tottimeInten = tottimeInten + etime(datevec(t2) , datevec(t1));
          
           %==== Shape
           t1 = datetime; % ~~~itemized time~~~

		   bw = S>0;
		   regnProps = regionprops('table',bw,'all');
		   csvwrite (outfilepath, OutTable); % < represent with this csv writing instead ||| super long > writetable (regnProps{}, outfilepath);
		    
           % ~~~itemized time~~~
           t2 = datetime;
           tottimeShape = tottimeShape + etime(datevec(t2) , datevec(t1));

           %==== save: advance row counter
           nextRow = nextRow + 1;

end
 
% save the result
csvwrite (outfilepath, OutTable);

% itemized timing
fprintf (1, "itemized timing (sec)\tintensity %f\tshape %f\ttexture %f\n", tottimeInten, tottimeShape, tottimeTexture);
 
% timestamp 2/2
toc
 
