"""
This file shows how to fit a GIF to some experimental data.
More instructions are provided on the website. 
"""

from Experiment import *
from AEC_Badel import *
from GIF import *
from Filter_Rect_LogSpaced import *

import Tools
import matplotlib.pyplot as plt

PATH1 = '../Data/Depolarizationblock/FilesNumpy/'
PATH2 = '../Data/DepolarizingNoSpikes/FilesNumpy/'
PATH3 = '../Data/DepolarizingSpikes/FilesNumpy/'
PATH4 = '../Data/Hyperpolarizing/FilesNumpy/'

############################################################################################################
# STEP 1: LOAD EXPERIMENTAL DATA
############################################################################################################

myExp = Experiment('Experiment 1', 0.1)
vunits = 10**-3
iunits = 10**-11
dur = 3000.0

# Load AEC data
AECtrace = np.load(PATH2 + 'model_14703002_Cell_20_pA.npy')
AECinput = np.load(PATH2 + 'modelCIP_14703002_Cell_20_pA.npy')
myExp.setAECTrace(AECtrace, vunits, AECinput, iunits, dur, FILETYPE='Array')

# Load training set data
TRAINtrace = np.load(PATH3 + 'model_14205006_Cell_50_pA.npy')
TRAINinput = np.load(PATH3 + 'modelCIP_14205006_Cell_50_pA.npy')
myExp.addTrainingSetTrace(TRAINtrace, vunits, TRAINinput, iunits, dur, FILETYPE='Array')

# Load test set data
DBtrace1 = np.load(PATH1 + 'model_14205006_Cell_450_pA.npy')
DBinput1 = np.load(PATH1 + 'modelCIP_14205006_Cell_450_pA.npy')
DBtrace2 = np.load(PATH1 + 'model_14205006_Cell_550_pA.npy')
DBinput2 = np.load(PATH1 + 'modelCIP_14205006_Cell_550_pA.npy')
myExp.addTestSetTrace(DBtrace1, vunits, DBinput1, iunits, dur, FILETYPE='Array')
myExp.addTestSetTrace(DBtrace2, vunits, DBinput2, iunits, dur, FILETYPE='Array')

PDtrace1 = np.load(PATH2 + 'model_14708004_Cell_10_pA.npy')
PDinput1 = np.load(PATH2 + 'modelCIP_14708004_Cell_10_pA.npy')
PDtrace2 = np.load(PATH2 + 'model_14708004_Cell_20_pA.npy')
PDinput2 = np.load(PATH2 + 'modelCIP_14708004_Cell_20_pA.npy')
myExp.addTestSetTrace(PDtrace1, vunits, PDinput1, iunits, dur, FILETYPE='Array')
myExp.addTestSetTrace(PDtrace2, vunits, PDinput2, iunits, dur, FILETYPE='Array')

ADtrace1 = np.load(PATH3 + 'model_14708004_Cell_50_pA.npy')
ADinput1 = np.load(PATH3 + 'modelCIP_14708004_Cell_50_pA.npy')
ADtrace2 = np.load(PATH3 + 'model_14708004_Cell_60_pA.npy')
ADinput2 = np.load(PATH3 + 'modelCIP_14708004_Cell_60_pA.npy')
myExp.addTestSetTrace(ADtrace1, vunits, ADinput1, iunits, dur, FILETYPE='Array')
myExp.addTestSetTrace(ADtrace2, vunits, ADinput2, iunits, dur, FILETYPE='Array')

Htrace1 = np.load(PATH4 + 'model_14205006_Cell_-100_pA.npy')
Hinput1 = np.load(PATH4 + 'modelCIP_14205006_Cell_-100_pA.npy')
Htrace2 = np.load(PATH4 + 'model_14703002_Cell_-90_pA.npy')
Hinput2 = np.load(PATH4 + 'modelCIP_14703002_Cell_-90_pA.npy')
myExp.addTestSetTrace(Htrace1, vunits, Hinput1, iunits, dur, FILETYPE='Array')
myExp.addTestSetTrace(Htrace2, vunits, Hinput2, iunits, dur, FILETYPE='Array')

# Plot data
myExp.plotTrainingSet()
myExp.plotTestSet()


############################################################################################################
# STEP 2: ACTIVE ELECTRODE COMPENSATION
############################################################################################################

# Create new object to perform AEC
myAEC = AEC_Badel(myExp.dt)

# Define metaparametres
myAEC.K_opt.setMetaParameters(length=150.0, binsize_lb=myExp.dt, binsize_ub=2.0, slope=30.0, clamp_period=1.0)
myAEC.p_expFitRange = [3.0,150.0]  
myAEC.p_nbRep = 15     

# Assign myAEC to myExp and compensate the voltage recordings
myExp.setAEC(myAEC)  
myExp.performAEC()  

# Plot AEC filters (Kopt and Ke)
myAEC.plotKopt()
myAEC.plotKe()

# Plot training and test set
myExp.plotTrainingSet()
myExp.plotTestSet()


############################################################################################################
# STEP 3: FIT GIF MODEL TO DATA
############################################################################################################

# Create a new object GIF 
myGIF = GIF(0.1)

# Define parameters
myGIF.Tref = 4.0  

myGIF.eta = Filter_Rect_LogSpaced()
myGIF.eta.setMetaParameters(length=500.0, binsize_lb=2.0, binsize_ub=1000.0, slope=4.5)

myGIF.gamma = Filter_Rect_LogSpaced()
myGIF.gamma.setMetaParameters(length=500.0, binsize_lb=5.0, binsize_ub=1000.0, slope=5.0)

# Define the ROI of the training set to be used for the fit (in this example we will use only the first 100 s)
myExp.trainingset_traces[0].setROI([[0,100000.0]])

# To visualize the training set and the ROI call again
myExp.plotTrainingSet()

# Perform the fit
myGIF.fit(myExp, DT_beforeSpike=5.0)

# Plot the model parameters
myGIF.printParameters()
myGIF.plotParameters()   

# Save the model
myGIF.save('./myGIF.pck')


############################################################################################################
# STEP 3A (OPTIONAL): PLAY A BIT WITH THE FITTED MODEL
############################################################################################################
"""
# Reload the model
myGIF = GIF.load('./myGIF.pck')

# Generate OU process with temporal correlation 3 ms and mean modulated by a sinusoildal function of 1 Hz
I_OU = Tools.generateOUprocess_sinMean(f=1.0, T=5000.0, tau=3.0, mu=0.3, delta_mu=0.5, sigma=0.1, dt=0.1)

# Simulate the model with the I_OU current. Use the reversal potential El as initial condition (i.e., V(t=0)=El)
(time, V, I_a, V_t, S) = myGIF.simulate(I_OU, myGIF.El)

# Plot the results of the simulation
plt.figure(figsize=(14,5), facecolor='white')
plt.subplot(2,1,1)
plt.plot(time, I_OU, 'gray')
plt.ylabel('I (nA)')
plt.subplot(2,1,2)
plt.plot(time, V,'black', label='V')
plt.plot(time, V_t,'red', label='V threshold')
plt.ylabel('V (mV)')
plt.xlabel('Time (ms)')
plt.legend()
plt.show()
"""


############################################################################################################
# STEP 4: EVALUATE THE GIF MODEL PERFORMANCE (USING MD*)
############################################################################################################

# Use the myGIF model to predict the spiking data of the test data set in myExp
myPrediction = myExp.predictSpikes(myGIF, nb_rep=500)

# Compute Md* with a temporal precision of +/- 4ms
Md = myPrediction.computeMD_Kistler(4.0, 0.1)    

# Plot data vs model prediction
myPrediction.plotRaster(delta=1000.0) 



