//
//  KPCSun.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import "KPCSun.h"
#import "KPCTimes.h"
#import "KPCSky.h"
#import "KPCScientificConstants.h"

// Ref: Jean Meeus' Astronomical Algorithms, p. 144
double sunMeanAnomalyForJulianDay(double jd)
{
	double T = julianCenturyForJulianDay(jd);
	double M = 357.5291092 + 35999.0502909*T - 0.0001536*T*T + T*T*T/24490000.0;
	M = fmod(M+360.0, 360.0); // Ensure it is comprised between 0 and 360.0;
	return M;
}

// Ref: Jean Meeus' Astronomical Algorithms, p. 144
double sunMeanLongitudeForJulianDay(double jd)
{
	double T = julianCenturyForJulianDay(jd);
	double L = 280.4665 + 36000.7698*T;
	L = fmod(L+360.0, 360.0); // Ensure it is comprised between 0 and 360.0;
	return L;
}

KPCAstronomicalCoordinatesComponents sunCoordinatesComponentsForJulianDay(double jd)
{
    // Low precision formula from Almanac. See also J. Thorstensen (skycalc)
	// ra and dec must be decimal (hours and degrees respectively).
	
	double n       = jd - J2000;
	double L       = 280.460 + 0.9856474 * n;
	double g       = (357.528 + 0.9856003 * n) * DEG2RAD;
	double lambda  = (L + 1.915 * sin(g) + 0.020 * sin(2. * g)) * DEG2RAD;
	double epsilon = (23.439 - 0.0000004 * n) * DEG2RAD;
	
	double x = cos(lambda);
	double y = cos(epsilon) * sin(lambda);
	double z = sin(epsilon) * sin(lambda);
	
	// atan2(numerator, denominator) -> atan2(y, x) = atan2(y/x).
	double RA = atan2(y, x);
	while (RA < 0.) {
		RA = RA + 2*M_PI;
	}
	double Dec = asin(z);

	KPCCoordinatesComponents base;
    base.theta = RA * RAD2HOUR;
    base.phi = Dec * RAD2DEG;
    base.units = KPCCoordinatesUnitsHoursAndDegrees;

    KPCAstronomicalCoordinatesComponents components;
    components.base = base;
    components.epoch = KPCJulianEpochStandard();
    components.system = KPCAstronomicalCoordinatesSystemEquatorial;
    
	return components;
}

double sunAzimuthForJulianDayLongitudeLatitude(double jd, double longitude, double latitude)
{
	KPCAstronomicalCoordinatesComponents components = sunCoordinatesComponentsForJulianDay(jd);
    return KPCSkyAzimuthForJulianDayRADecLongitudeLatitude(jd, components.base.theta, components.base.phi, longitude, latitude);
}

double sunAltitudeForJulianDayLongitudeLatitude(double jd, double longitude, double latitude)
{
	KPCAstronomicalCoordinatesComponents components = sunCoordinatesComponentsForJulianDay(jd);
    return KPCSkyAltitudeForJulianDayRADecLongitudeLatitude(jd, components.base.theta, components.base.phi, longitude, latitude);
}

// See Jean Meeus' Astronomical Algorithms p. 178 Table 27.B
double marchEquinoxJulianDayForYear(double y)
{
	if (y != round(y)) {
		return NAN;
	}
	
	double Y = (y - 2000.0)/1000.0;
	double jd0 = 2451623.80984 + 365242.37404*Y + 0.05169*Y*Y - 0.00411*Y*Y*Y - 0.00057*Y*Y*Y*Y;
	
	double T = (jd0 - J2000) / 36525;
	double W = 35999.373*T - 2.47;
	double Delta_lambda = 1 + 0.0334*cos(W*DEG2RAD) + 0.0007*cos(2*W*DEG2RAD);

	static const double A[24] = {485.0, 203.0, 199.0, 182.0, 156.0, 136.0, 77.0, 74.0, 70.0, 58.0, 52.0, 50.0, 45.0, 44.0, 29.0, 18.0, 17.0, 16.0, 14.0, 12.0, 12.0, 12.0, 9.0, 8.0};
	static const double B[24] = {324.96, 337.23, 342.08, 27.85, 73.14, 171.52, 222.54, 296.72, 243.58, 119.81, 297.17, 21.02, 247.54, 325.15, 60.93, 155.12, 288.79, 198.04, 199.76, 95.39, 287.11, 320.81, 227.73, 15.45};
	static const double C[24] = {1934.136, 32964.467, 20.186, 445267.112, 45036.886, 22518.443, 65928.934, 3034.906, 9037.513, 33718.147, 150.678, 2281.226, 29929.562, 31555.956, 4443.417, 67555.328, 4562.452, 62894.029, 31436.921, 14577.848, 31931.756, 34777.259, 1222.114, 16859.074};
	
	double S = 0.0;
	for (int i = 0; i < 24; i++) {
		S += A[i]*cos((B[i]+C[i]*T)*DEG2RAD);
	}
	
	double jd = jd0 + (0.00001*S)/Delta_lambda;
	return jd;
	
	
}
