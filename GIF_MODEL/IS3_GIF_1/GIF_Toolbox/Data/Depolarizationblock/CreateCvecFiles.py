import scipy.io as sio
import matplotlib.pyplot as plt
import numpy as np

Cell = 14227002
CIP = 700

tvec = np.arange(0.1,3000.1,0.1)
vvec_load = sio.loadmat('model_' + str(Cell) + '_Cell_' + str(CIP) + '_pA.mat')
vvec = vvec_load['m']

cvec_part1 = np.zeros(2470)
cvec_part2 = np.ones(7500)*CIP
cvec_part3 = np.zeros(20030)
cvec = np.concatenate((cvec_part1, cvec_part2, cvec_part3), axis = 0)

plt.figure()
plt.subplot(211)
plt.plot(tvec,vvec,'b')
plt.ylabel('Voltage (mV)')
plt.axis([0, max(tvec), min(vvec)-5, 50])

plt.subplot(212)
plt.plot(tvec,cvec,'r')
plt.xlabel('Time (ms)')
plt.ylabel('Current (pA)')
plt.axis([0, max(tvec), min(cvec), CIP+50])
plt.show()

np.save('FilesNumpy/model_' + str(Cell) + '_Cell_' + str(CIP) + '_pA.npy',vvec)
np.save('FilesNumpy/modelCIP_' + str(Cell) + '_Cell_' + str(CIP) + '_pA.npy',cvec)
