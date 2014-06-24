//
//  STLEarth.m
//  iObserve
//
//  Created by Cédric Foellmi on 8/5/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCEarth.h"
#import "KPCTerrestrialCoordinates.h"
#import "KPCScientificConstants.h"

// See p.85 of AA.
double accurateEarthPointsSeparationDistance(KPCTerrestrialCoordinates *c1, KPCTerrestrialCoordinates *c2)
{
	double a = EARTH_RADIUS_KM;
	double f = EARTH_RADIUS_FLATTENING_FACTOR;
	
	double phi1 = [c1 latitude]*DEG2RAD;
	double phi2 = [c2 latitude]*DEG2RAD;
	double L1 = [c1 longitude]*DEG2RAD;
	double L2 = [c2 longitude]*DEG2RAD;

	double F = (phi1 + phi2)/2.0;
	double G = (phi1 - phi2)/2.0;
	double lambda = (L1 - L2)/2.0;
	
	double S = sin(G)*sin(G)*cos(lambda)*cos(lambda) + cos(F)*cos(F)*sin(lambda)*sin(lambda);
	double C = cos(F)*cos(G)*cos(lambda)*cos(lambda) + sin(F)*sin(F)*sin(lambda)*sin(lambda);
	
	double tanOmega = sqrt(S/C);
	double omega = atan(tanOmega); // in radians.
	
	double R = sqrt(S*C) / omega;
	
	double D = 2.0*omega*a;
	double H1 = (3.0*R - 1.0) / (2.0*C);
	double H2 = (3.0*R + 1.0) / (2.0*S);
	
	double s = D*(1.0 + f*H1*sin(F)*sin(F)*cos(G)*cos(G) - f*H2*cos(F)*cos(F)*sin(G)*sin(G));
	return s;
}


