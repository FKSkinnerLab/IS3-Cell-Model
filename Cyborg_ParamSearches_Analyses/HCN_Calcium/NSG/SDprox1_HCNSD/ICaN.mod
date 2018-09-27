:[$URL: https://bbpteam.epfl.ch/svn/analysis/trunk/IonChannel/xmlTomod/CreateMOD.c $]
:[$Revision: 1367 $]
:[$Date: 2010-03-26 15:17:59 +0200 (Fri, 26 Mar 2010) $]
:[$Author: rajnish $]
:Comment :
:Reference :Activation and inactivation properties of voltage-gated calcium currents in developing cat retinal ganglion cells. Neuroscience, 1998, 85, 239-47

NEURON	{
	SUFFIX Cav2_2_0079
	USEION ca READ eca WRITE ica
	RANGE gCav2_2bar, gCav2_2, ica, BBiD 
}

UNITS	{
	(S) = (siemens)
	(mV) = (millivolt)
	(mA) = (milliamp)
}

PARAMETER	{
	gCav2_2bar = 0.00001 (S/cm2) 
	BBiD = 79 
}

ASSIGNED	{
	v	(mV)
	eca	(mV)
	ica	(mA/cm2)
	gCav2_2	(S/cm2)
	mInf
	mTau
	mAlpha
	mBeta
	hInf
	hTau
	hAlpha
	hBeta
}

STATE	{ 
	m
	h
}

BREAKPOINT	{
	SOLVE states METHOD cnexp
	gCav2_2 = gCav2_2bar*m*m*h
	ica = gCav2_2*(v-eca)
}

DERIVATIVE states	{
	rates()
	m' = (mInf-m)/mTau
	h' = (hInf-h)/hTau
}

INITIAL{
	rates()
	m = mInf
	h = hInf
}

PROCEDURE rates(){
	UNITSOFF
		if(v == 20){
			v = v + 0.000001
		}
		mAlpha = (0.1*(v-20)/(1-exp(-(v-20)/10))) 
		mBeta = 0.4*exp(-(v+25)/18)
		mInf = mAlpha/(mAlpha + mBeta)
		mTau = 1/(mAlpha + mBeta) 
		hAlpha = 0.01*exp(-(v+50)/10) 
		hBeta = 0.1/(1+exp(-(v+17)/17))
		hInf = hAlpha/(hAlpha + hBeta)
		hTau = 1/(hAlpha + hBeta)
	UNITSON
}
