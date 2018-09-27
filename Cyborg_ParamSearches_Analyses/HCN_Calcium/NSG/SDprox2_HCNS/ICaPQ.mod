:[$URL: https://bbpteam.epfl.ch/svn/analysis/trunk/IonChannel/xmlTomod/CreateMOD.c $]
:[$Revision: 1367 $]
:[$Date: 2010-03-26 15:17:59 +0200 (Fri, 26 Mar 2010) $]
:[$Author: rajnish $]
:Comment :
:Reference :Low-threshold potassium channels and a low-threshold calcium channel regulate Ca2+ spike firing in the dendrites of cerebellar Purkinje neurons: a modeling study. Brain Res., 2001, 891, 106-15

NEURON	{
	SUFFIX Cav2_1_0078
	USEION ca READ eca WRITE ica
	RANGE gCav2_1bar, gCav2_1, ica, BBiD 
}

UNITS	{
	(S) = (siemens)
	(mV) = (millivolt)
	(mA) = (milliamp)
}

PARAMETER	{
	gCav2_1bar = 0.00001 (S/cm2) 
	BBiD = 78 
}

ASSIGNED	{
	v	(mV)
	eca	(mV)
	ica	(mA/cm2)
	gCav2_1	(S/cm2)
	mInf
	mTau
	mAlpha
	mBeta
}

STATE	{ 
	m
}

BREAKPOINT	{
	SOLVE states METHOD cnexp
	gCav2_1 = gCav2_1bar*m
	ica = gCav2_1*(v-eca)
}

DERIVATIVE states	{
	rates()
	m' = (mInf-m)/mTau
}

INITIAL{
	rates()
	m = mInf
}

PROCEDURE rates(){
	UNITSOFF 
		mAlpha = 8.5/(1+exp((v-8)/(-12.5))) 
		mBeta = 35/(1+exp((v+74)/(14.5)))
		mInf = mAlpha/(mAlpha + mBeta)
		mTau = 1/(mAlpha + mBeta)
	UNITSON
}
