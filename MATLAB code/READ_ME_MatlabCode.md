TGS Matlab Scripts read me

The files in this folder can be used to analyze the TGS data for frequency and thermal diffusivity information. 
This paper focuses only on thermal diffusivity. To use the scripts, they should be saved to the same folder as the data file 
of interest.

To calculate SAW frequency of a given spot, the following command is issued: 

                          param_extract_time(1, 'positive file name.txt','negative file name.txt',gs,0) 
                          
where gs is the calibrated grating spacing.* The positive and negative files should correspond to the same trace (1, 2, or 3).
When MATLAB runs the function, a Fourier transform of the data is plotted. The user must click to the left and then to the right
of the main peak. MATLAB will then return the location of the Fourier transform peak. Multiplying this frequency output [1/s]
by the calibrated grating spacing in [m] yields SAW speed in [m/s]. Note that the script does not run through the three sets of traces
associated with each spot automatically. 

To calculate the thermal diffusivity, the following command is issued:

                          thermal_phase('positive file name.txt','negative file name.txt',gs,2)
                         
Typically, if there are many spots to analyze, it's easier to create a script that will allow you to complete the necessary analysis
without manually updating the positive and negative file names each time.** One easy way to do this is to write a very simple MATLAB 
script that allows for the easy updating of many file names at once via Ctrl-F. It may be preferable to write something even more 
automated, but this method can be advantageous when working with large data sets (e.g. the niobium data was taken over 70+ different days
over the course ofa year) in which naming conventions were not always consistent.

An example (truncated) script might look like this:

gs=5.48099;
temp=zeros(10,3);

temp(1,1)=param_extract_time(1,'NiAl_II_Sample10_5.5-2018-03-30-05.50um-spot01-POS-1.txt','NiAl_II_Sample10_5.5-2018-03-30-05.50um-spot01-NEG-1.txt',gs,0);
temp(2,1)=param_extract_time(1,'NiAl_II_Sample10_5.5-2018-03-30-05.50um-spot02-POS-1.txt','NiAl_II_Sample10_5.5-2018-03-30-05.50um-spot02-NEG-1.txt',gs,0);
...

temp(1,2)=param_extract_time(1,'NiAl_II_Sample10_5.5-2018-03-30-05.50um-spot01-POS-2.txt','NiAl_II_Sample10_5.5-2018-03-30-05.50um-spot01-NEG-2.txt',gs,0);
...

 Here, all the data was taken on the same day so only one grating spacing variable is needed. There were ten spots 
of interest (ten rows in the results matrix), with three traces per spot (three columns per results matrix). 

--------

*To collect a calibrated grating spacing for a given day, the SAW frequency is extracted from the tungsten calibration data collected on 
that day using the param_extract_time function. The known speed of sound in single crystal tungsten, 2665.9 m/s, is divided by this 
SAW frequency to determine the true grating spacing for that day. When calling param_extract_time to collect the tungsten frequency, the 
nominal grating spacing value is used in the argument (e.g. here the nominal grating spacing was 5.5 micrometers). 
**Note that the thermal_phase function returns three values in this iteration. The first value is thermal diffusivity. The second is 
thermal fit error, and the third is acoustic damping. Acoustic damping analysis is still in progress, and this third value should be 
ignored. However, knowing that the thermal_phase function returns three values is helpful when writing a script to run through multiple data
files and populate a matrix with results: it's necessary to specify that you want to collect the first of three returned values. 
