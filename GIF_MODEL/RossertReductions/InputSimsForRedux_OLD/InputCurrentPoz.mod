COMMENT
Written according to equations and parameter values taken from:
Pozzorini C, Mensi S, Hagens O, Naud R, Koch C, Gerstner W. (2015). Automated High-Throughput Characterization of Single Neurons by Means of Simplified Spiking Models. PLoS. Comput. Biol. 11(6):e1004275.
ENDCOMMENT

NEURON {
        POINT_PROCESS InputCurrentPoz
        RANGE del, dur, tau, io, freq, sigmao, dsigma, sigma
        NONSPECIFIC_CURRENT i
}

UNITS {
        (nA) = (nanoamp)
             }

PARAMETER {
        del=0   (ms)
        dur=0	(ms)
		tau=3	(ms)
        io=0.52	(nA)
        freq=0.0002	(/ms)
		sigmao=0.32	(nA)
		dsigma=0.5
        PI=3.14159265358979323846
		dt (ms)
}

ASSIGNED {
        i (nA)
		sigma (nA)
}

BREAKPOINT {
		at_time(del)
		at_time(del + dur)

		if (t < del) {
			i=0   
		}else{  
			if (t < del+dur) {
				i = i + ((io-i)*(dt/tau)) + sqrt(2*(sigma^2)*(dt/tau))*urand()
				: sigma(t) = sigmao*(1+dsigma*sin(2*PI*freq*t))
				sigma = sigma + 2*PI*sigmao*dsigma*(freq*dt)*cos(2*PI*(freq*t))
			}else{  
				i = 0
				}
			}
}

FUNCTION urand() {
		urand = scop_random()
}
