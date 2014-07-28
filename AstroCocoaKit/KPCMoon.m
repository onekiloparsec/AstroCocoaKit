//
//  STLMoon.m
//  iObserve
//
//  Created by Soft Tenebras Lux on 19/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import <math.h>

#import "KPCMoon.h"
#import "KPCSun.h"
#import "KPCSky.h"
#import "KPCTimes.h"
#import "KPCScientificConstants.h"

static NSCalendar *gregorianCalendar;

static const int argumentD[60] = {0, 2, 2, 0, 0, 0, 2, 2, 2, 2, 0, 1, 0, 2, 0, 0, 4, 0, 4, 2, 2, 1, 1, 2, 2, 4, 2, 0, 2, 2, 1, 2, 0, 0, 2, 2, 2, 4, 0, 3, 2, 4, 0, 2, 2, 2, 4, 0, 4, 1, 2, 0, 1, 3, 4, 2, 0, 1, 2, 2};

static const int argumentM[60] = {0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, -1, 0, 0, 0, 1, 0, -1, 0, -2, 1, 2, -2, 0, 0, -1, 0, 0, 1, -1, 2, 2, 1, -1, 0, 0, -1, 0, 1, 0, 1, 0, 0, -1, 2, 1, 0, 0};

static const int argumentMprime[60] = {1, -1, 0, 2, 0, 0, -2, -1, 1, 0, -1, 0, 1, 0, 1, 1, -1, 3, -2, -1, 0, -1, 0, 1, 2, 0, -3, -2, -1, -2, 1, 0, 2, 0, -1, 1, 0, -1, 2, -1, 1, -2, -1, -1, -2, 0, 1, 4, 0, -2, 0, 2, 1, -2, -3, 2, 1, -1, 3, -1};

static const int argumentF[60] = {0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -2, 2, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, -2, 2, 0, 2, 0, 0, 0, 0, 0, 0, -2, 0, 0, 0, 0, -2, -2, 0, 0, 0, 0, 0, 0, 0, -2};

static const int coeffEpsilonl[60] = {6288774, 1274027, 658314, 213618, -185116, -114332, 58793, 57066, 53322, 45758, -40923, -34720, -30383, 15327, -12528, 10980, 10675, 10034, 8548, -7888, -6766, -5163, 4987, 4036, 3994, 3861, 3665, -2689, -2602, 2390, -2348, 2236, -2120, -2069, 2048, -1773, -1595, 1215, -1110, -892, -810, 759, -713, -700, 691, 596, 549, 537, 520, -487, -399, -381, 351, -340, 330, 327, -323, 299, 294, 0};

static const int coeffEpsilonr[60] = {-20905355, -3699111, -2955968, -569925, 48888, -3149, 246158, -152138, -170733, -204586, -129620, 108743, 104755, 10321, 0, 79661, -34782, -23210, -21636, 24208, 30824, -8379, -16675, -12831, -10445, -11650, 14403, -7003, 0, 10056, 6322, -9884, 5751, 0, -4950, 4130, 0, -3958, 0, 3258, 2616, -1897, -2117, 2354, 0, 0, -1423, -1117, -1571, -1739, 0, -4421, 0, 0, 0, 0, 1165, 0, 0, 8752};

static const int argumentD2[60] = {0, 0, 0, 2, 2, 2, 2, 0, 2, 0, 2, 2, 2, 2, 2, 2, 2, 0, 4, 0, 0, 0, 1, 0, 0, 0, 1, 0, 4, 4, 0, 4, 2, 2, 2, 2, 0, 2, 2, 2, 2, 4, 2, 2, 0, 2, 1, 1, 0, 2, 1, 2, 0, 4, 4, 1, 4, 1, 4, 2};

static const int argumentM2[60] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 1, -1, -1, -1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 1, 1, 0, -1, -2, 0, 1, 1, 1, 1, 1, 0, -1, 1, 0, -1, 0, 0, 0, -1, -2};

static const int argumentMprime2[60] = {0, 1, 1, 0, -1, -1, 0, 2, 1, 2, 0, -2, 1, 0, -1, 0, -1, -1, -1, 0, 0, -1, 0, 1, 1, 0, 0, 3, 0, -1, 1, -2, 0, 2, 1, -2, 3, 2, -3, -1, 0, 0, 1, 0, 1, 1, 0, 0, -2, -1, 1, -2, 2, -2, -1, 1, 1, -1, 0, 0};

static const int argumentF2[60] = {1, 1, -1, -1, 1, -1, 1, 1, -1, -1, -1, -1, 1, -1, 1, 1, -1, -1, -1, 1, 3, 1, 1, 1, -1, -1, -1, 1, -1, 1, -3, 1, -3, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1, -1, 3, -1, -1, 1, -1, -1, 1, -1, 1, -1, -1, -1, -1, -1, -1, 1};

static const int coeffEpsilonb[60] = {5128122, 280602, 277693, 173237, 55413, 46271, 32573, 17198, 9266, 8822, 8216, 4324, 4200, -3359, 2463, 2211, 2065, -1870, 1828, -1794, -1749, -1565, -1491, -1475, -1410, -1344, -1335, 1107, 1021, 833, 777, 671, 607, 596, 491, -451, 439, 422, 421, -366, -351, 331, 315, 302, -283, -229, 223, 223, -220, -220, -185, 181, -177, 176, 166, -164, 132, -119, 115, 107};


// 0.125 degrees according to p. 102 of AA.
// But http://aa.usno.navy.mil/faq/docs/RST_defs.php gives between 54 and 61 arcminutes.
static const double HorizontalParallax_h0 = 0.161;

double moonLongitudePeriodicTerms(double D, double M, double Mprime, double Lprime, double F, double julianDay) 
{
	double T = (julianDay - J2000) / 36525.;
	double result = 0;
	
	for (int i = 0; i < 60; i ++) {
		double E = (argumentM[i] != 0) ? (1 - 0.002516*T - 0.0000074*T*T) : 1;
		double arg = fmod(argumentD[i]*D + argumentM[i]*M + argumentMprime[i]*Mprime + argumentF[i]*F, 360.0);
		result = result + coeffEpsilonl[i] * E * sin(arg * DEG2RAD);
	}
	
	double A1 = (119.75 +    131.849*T) * DEG2RAD;
	double A2 = ( 53.09 + 479264.290*T) * DEG2RAD;
	
	result = result + 3958*sin(A1) + 1962*sin((Lprime-F)*DEG2RAD) + 318*sin(A2);
	
	return result;
}

double moonLatitudePeriodicTerms(double D, double M, double Mprime, double Lprime, double F, double julianDay) 
{
	double T = (julianDay - J2000) / 36525.;
	double result = 0;
	
	for (int i = 0; i < 60; i ++) {
		double E = (argumentM2[i] != 0) ? (1 - 0.002516*T - 0.0000074*T*T) : 1;
		double arg = fmod(argumentD2[i]*D + argumentM2[i]*M + argumentMprime2[i]*Mprime + argumentF2[i]*F, 360.0);
		result = result + coeffEpsilonb[i] * E * sin(arg * DEG2RAD);
	}
	
	double A1 = (119.75 +    131.849*T) * DEG2RAD;
	double A3 = (313.45 + 481266.484*T) * DEG2RAD;
	
	result = result - 2235*sin(Lprime*DEG2RAD) + 382*sin(A3) + 
	175*sin(A1-F*DEG2RAD) + 175*sin(A1+F*DEG2RAD) + 
	127*sin((Lprime-Mprime)*DEG2RAD) - 115*sin((Lprime+Mprime)*DEG2RAD);
	
	return result;
}

double moonDistancePeriodicTerms(double D, double M, double Mprime, double F, double julianDay) 
{
	double T = (julianDay - J2000) / 36525.;
	double result = 0;
	
	for (int i = 0; i < 60; i ++) {
		double E = (argumentM[i] != 0) ? (1 - 0.002516*T - 0.0000074*T*T) : 1;
		double arg = fmod(argumentD[i]*D + argumentM[i]*M + argumentMprime[i]*Mprime + argumentF[i]*F, 360.0);
		result = result + coeffEpsilonr[i] * E * cos(arg * DEG2RAD);
	}
	
	return result;
}

double moonMeanLongitude(double julianDay)
{
	// Moon's mean longitude, referred to the mean equinox of the date, and including the constant
	// term of the effect of the light-time (-0''.70)
	double T = (julianDay - J2000) / 36525.;
	double Lprime = 218.3164477 + 481267.88123421*T - 0.0015786*T*T + T*T*T/538841.0 - T*T*T*T/65194000.0;
	Lprime = fmod(Lprime, 360.0);
	if (Lprime < 0) Lprime += 360.0;
	return Lprime;
}

double moonMeanElongation(double julianDay)
{
	// Mean elongation of the Moon
	double T = (julianDay - J2000) / 36525.;
	double result = 297.8501921 + 445267.1114034*T - 0.0018819*T*T + T*T*T/545868.0 - T*T*T*T/113065000.0;
	result = fmod(result, 360.0);
	if (result < 0) result += 360.0;
	return result;
}

double moonMeanAnomaly(double julianDay)
{
	double T = (julianDay - J2000) / 36525.;
	double Mprime = 134.9633964 + 477198.8675055*T + 0.0087414*T*T + T*T*T/69699.0 - T*T*T*T/14712000.0;
	Mprime = fmod(Mprime, 360.0);
	if (Mprime < 0) Mprime += 360.0;
	return Mprime;
}

double moonArgumentOfLatitude(double julianDay)
{
	double T = (julianDay - J2000) / 36525.;
	// Moon's argument of latitude (mean distance of the Moon from its ascending node)
	double F = 93.2720950 + 483202.0175233*T - 0.0036539*T*T + T*T*T/3526000.0 + T*T*T*T/863310000.0;
	F = fmod(F, 360.0);
	if (F < 0) F += 360.0;
	return F;
}

double moonMeanEclipticOrbitAscendingNodeLongitude(double julianDay)
{
	// Longitude of the ascending node of the Moon's mean orbit on the ecliptic, measured from the mean equinox of the date
	double T = (julianDay - J2000) / 36525.;
	double Omega = 125.04452 - 1934.136261*T + 0.0020708*T*T + T*T*T/450000.0;
	Omega = fmod(Omega, 360.0);
	if (Omega < 0) Omega += 360.0;
	return Omega;
}

// See AA. Chapter 47 (pp 337...)
KPCAstronomicalCoordinatesComponents moonCoordinatesComponentsForJulianDay(double julianDay)
{
	// All terms below are expressed in degrees.
	
	double Lprime = moonMeanLongitude(julianDay);
	double D = moonMeanElongation(julianDay);
	double Mprime = moonMeanAnomaly(julianDay);
	double F = moonArgumentOfLatitude(julianDay);
	double Omega = moonMeanEclipticOrbitAscendingNodeLongitude(julianDay);
	
	double M = sunMeanAnomalyForJulianDay(julianDay);
	double L = sunMeanLongitudeForJulianDay(julianDay);
	
	double Epsilonl = moonLongitudePeriodicTerms(D, M, Mprime, Lprime, F, julianDay);
	double Epsilonb = moonLatitudePeriodicTerms(D, M, Mprime, Lprime, F, julianDay);
	
	// Ecliptic coordinates lambda & beta
	double lambda = fmod(Lprime + Epsilonl / 1000000., 360.0);
	if (lambda < 0) lambda += 360.0;
	
	double beta = fmod(Epsilonb / 1000000, 360.0);	
	
	// Nutation in longitude and obliquity (SEE AA p.144 for DeltaEpsilon & Epsilon0).
	double DeltaPsi = -17.20*sin(Omega*DEG2RAD) - 1.32*sin(2*L*DEG2RAD)
	- 0.23*sin(2*Lprime*DEG2RAD) + 0.21*sin(2*Omega*DEG2RAD);
	
	double DeltaEpsilon = 9.20*cos(Omega*DEG2RAD) + 0.57*cos(2*L*DEG2RAD) +
	0.10*cos(2*Lprime*DEG2RAD) - 0.09*cos(2*Omega*DEG2RAD);
	
	// In degrees
	DeltaPsi = fmod(DeltaPsi / 3600, 360.0);
	if (DeltaPsi < 0) DeltaPsi += 360.0;
	
	DeltaEpsilon = fmod(DeltaEpsilon / 3600., 360.0);
	if (DeltaEpsilon < 0) DeltaEpsilon += 360.0;
	
	double T = (julianDay - J2000) / 36525.0;
	
	// See AA p.147 (in degrees)
	double Epsilon0 = (23.*3600 + 26.*60. + 21.448 - 46.8150*T - 0.00059*T*T + 0.001813*T*T*T) / 3600.0;
	Epsilon0 = fmod(Epsilon0, 360.);
	if (Epsilon0 < 0) Epsilon0 += 360.0;
	
	// True obliquity of the ecliptic. In radians
	double epsilon = Epsilon0 + DeltaEpsilon;
	
	// Apparent longitude. In radians
	double apparentLambda = lambda + DeltaPsi;	
	
	// Transform all to radians
	apparentLambda *= DEG2RAD;
	epsilon *= DEG2RAD;
	beta *= DEG2RAD;
	
	double x = sin(apparentLambda)*cos(epsilon) - tan(beta)*sin(epsilon);
	double y = cos(apparentLambda);
	double sinDelta = sin(beta)*cos(epsilon) + cos(beta)*sin(epsilon)*sin(apparentLambda);

	double RA = atan2(x, y) * RAD2HOUR;
	double Dec = asin(sinDelta) * RAD2DEG;

	if (RA < 0.0) {
		RA += 24.0;
	}

	KPCCoordinatesComponents base;
	base.theta = RA;
	base.phi = Dec;
    base.units = KPCCoordinatesUnitsHoursAndDegrees;
    
    KPCAstronomicalCoordinatesComponents components;
    components.base = base;
    components.epoch = KPCJulianEpochStandard();
    components.system = KPCAstronomicalCoordinatesSystemEquatorial;
	
	return components;
}

double moonAltitudeForJulianDay(double julianDay, KPCCoordinatesComponents obsCoords)
{
    KPCAstronomicalCoordinatesComponents moonCoords = moonCoordinatesComponentsForJulianDay(julianDay);
	return KPCSkyAltitudeForJulianDayRADecLongitudeLatitude(julianDay,
													  moonCoords.base.theta,
													  moonCoords.base.phi,
													  obsCoords.theta,
													  obsCoords.phi);
}

double moonAzimuthForJulianDay(double julianDay, KPCCoordinatesComponents obsCoords)
{
    KPCAstronomicalCoordinatesComponents moonCoords = moonCoordinatesComponentsForJulianDay(julianDay);
	return KPCSkyAzimuthForJulianDayRADecLongitudeLatitude(julianDay,
													 moonCoords.base.theta,
													 moonCoords.base.phi,
													 obsCoords.theta,
													 obsCoords.phi);
}

// INFERRED FROM SKYCALC "flmoon" function.
// Gives jd (+- 2 min) of phase nph on lunation n; replace less accurate Numerical Recipes routine.  This routine
// implements formulae found in Jean Meeus' *Astronomical Formula for Calculators*, 2nd edition, Willman-Bell. 
// n, nph lunation and phase; nph = 0 new, 1 1st, 2 full, 3 last 
double julianDateForMoonLunationAndPhase(int aMoonLunation, int aMoonPhase)
{	
	double jd, cor;
	double M, Mpr, F;
	double T;
	double lun;
	
	lun = (float)aMoonLunation + (float)aMoonPhase / 4.;
	T   = lun / 1236.85;
	jd  = 2415020.75933 + 29.53058868 * lun + 0.0001178 * T*T - 0.000000155 * T*T*T 
	+ 0.00033 * sin((166.56 + 132.87 * T - 0.009173 * T*T)*DEG2RAD);
	M   = (359.2242 + 29.10535608 * lun - 0.0000333 * T*T - 0.00000347 * T*T*T) * DEG2RAD;
	Mpr = (306.0253 + 385.81691806 * lun + 0.0107306 * T*T + 0.00001236 * T*T*T) * DEG2RAD;
	F   = (21.2964 + 390.67050646 * lun - 0.0016528 * T * T - 0.00000239 * T*T*T) *DEG2RAD;
	
	if((aMoonPhase == 0) || (aMoonPhase == 2)) {/* new or full */
		cor = (0.1734 - 0.000393*T) * sin(M)
		+ 0.0021 * sin(2*M)
		- 0.4068 * sin(Mpr)
		+ 0.0161 * sin(2*Mpr)
		- 0.0004 * sin(3*Mpr)
		+ 0.0104 * sin(2*F)
		- 0.0051 * sin(M + Mpr)
		- 0.0074 * sin(M - Mpr)
		+ 0.0004 * sin(2*F+M)
		- 0.0004 * sin(2*F-M)
		- 0.0006 * sin(2*F+Mpr)
		+ 0.0010 * sin(2*F-Mpr)
		+ 0.0005 * sin(M+2*Mpr);
	} else {
		cor = (0.1721 - 0.0004*T) * sin(M)
		+ 0.0021 * sin(2 * M)
		- 0.6280 * sin(Mpr)
		+ 0.0089 * sin(2 * Mpr)
		- 0.0004 * sin(3 * Mpr)
		+ 0.0079 * sin(2*F)
		- 0.0119 * sin(M + Mpr)
		- 0.0047 * sin(M - Mpr)
		+ 0.0003 * sin(2 * F + M)
		- 0.0004 * sin(2 * F - M)
		- 0.0006 * sin(2 * F + Mpr)
		+ 0.0021 * sin(2 * F - Mpr)
		+ 0.0003 * sin(M + 2 * Mpr)
		+ 0.0004 * sin(M - 2 * Mpr)
		- 0.0003 * sin(2*M + Mpr);
		if(aMoonPhase == 1) cor = cor + 0.0028 - 0.0004 * cos(M) + 0.0003 * cos(Mpr);
		if(aMoonPhase == 3) cor = cor - 0.0028 + 0.0004 * cos(M) - 0.0003 * cos(Mpr);		
	}
	jd = jd + cor;
	return jd;
}

#pragma mark - Age & Illumination

// INFERRED FROM SKYCALC "lun_age" function.
double moonAgeForJulianDate(double aJulianDate)
{
	int nlast;
	double newjd, lastnewjd;
	short kount=0;
	double x;
	
	nlast = (aJulianDate - 2415020.5) / 29.5307 - 1;  /* find current lunation */
	
	lastnewjd = julianDateForMoonLunationAndPhase(nlast, 0);
	nlast++;
	newjd     = julianDateForMoonLunationAndPhase(nlast, 0);
	
	while((newjd < aJulianDate) && (kount < 40)) {
		lastnewjd = newjd;
		nlast++;
		newjd = julianDateForMoonLunationAndPhase(nlast, 0);
	}
	if(kount > 35) {  /* oops ... didn't find it ... */
		NSLog(@"[iObserve: Moon,m - WARNING], Moon.m: Didn't find phase in ageForJulianDate!");
		x = -10.;
	} else {
		x = aJulianDate - lastnewjd;
	}
	return x;
}

// INFERRED FROM SKYCALC
NSString *formattedMoonAgeForJulianDay(double julianDay)
{
	int nlast;
	long int noctiles;
	double newjd, lastnewjd;
	short kount = 0;
	double x;
	NSString *age;
	
	nlast = (julianDay - 2415020.5) / 29.5307 - 1;  /* find current lunation */
	
	lastnewjd = julianDateForMoonLunationAndPhase(nlast, 0);
	nlast++;
	newjd     = julianDateForMoonLunationAndPhase(nlast, 0);
	
	while((newjd < julianDay) && (kount < 40)) {
		lastnewjd = newjd;
		nlast++;
		newjd = julianDateForMoonLunationAndPhase(nlast, 0);
	}
	if(kount > 35) {  /* oops ... didn't find it ... */
		NSLog(@"[iObserve: Moon.m - WARNING], Moon.m: Didn't find phase in ageForJulianDate!");
	} else {
		x = julianDay - lastnewjd;
		nlast--;
		noctiles = lrintf(x / 3.69134);  /* 3.69134 = 1/8 month; truncate. */
		if (noctiles == 0) {
			age = [NSString stringWithFormat:@"%3.1f days since new moon", x];
		} else if (noctiles <= 2) {  /* nearest first quarter */
			double firstQuarterJD = julianDateForMoonLunationAndPhase(nlast, 1);
			x = julianDay - firstQuarterJD;
			if(x < 0.)
				age = [NSString stringWithFormat:@"%3.1f days before first quarter", -1*x];
			else
				age = [NSString stringWithFormat:@"%3.1f days since first quarter",x];
		} else if (noctiles <= 4) {  /* nearest full */
			double fullMoonJD = julianDateForMoonLunationAndPhase(nlast, 2);
			x = julianDay - fullMoonJD;
			if(x < 0.)
				age = [NSString stringWithFormat:@"%3.1f days before full moon", -1*x];
			else
				age = [NSString stringWithFormat:@"%3.1f days after full moon", x];
		} else if (noctiles <= 6) {  /* nearest last quarter */
			double lastQuarterJD = julianDateForMoonLunationAndPhase(nlast, 3);
			x = julianDay - lastQuarterJD;
			if(x < 0.)
				age = [NSString stringWithFormat:@"%3.1f days before last quarter", -1.*x];
			else
				age = [NSString stringWithFormat:@"%3.1f days after last quarter", x];
		} else {
			age = [NSString stringWithFormat:@"%3.1f days before new moon", newjd - julianDay];
		}
	}
	return age;	
}

double moonAgeForDate(NSDate *date)
{
	double jd = julianDayForDate(date);
	return moonAgeForJulianDate(jd);
}

NSString *formattedMoonAgeForDate(NSDate *date)
{
	double jd = julianDayForDate(date);
	return formattedMoonAgeForJulianDay(jd);
}

// See AA Equ 48.4 p 346
double moonIlluminationFractionForJulianDay(double julianDay)
{
	double D = moonMeanElongation(julianDay);
	double Mprime = moonMeanAnomaly(julianDay);
	double M = sunMeanAnomalyForJulianDay(julianDay);
	
	double i = 180 - D 
	- 6.289 * sin(Mprime*DEG2RAD)
	+ 2.100 * sin(M*DEG2RAD)
	- 1.274 * sin((2*D-Mprime)*DEG2RAD)
	- 0.658 * sin(2*D*DEG2RAD)
	- 0.214 * sin(2*Mprime*DEG2RAD)
	- 0.110 * sin(D*DEG2RAD);
	
	return (1 + cos(i*DEG2RAD))/2.;
}


#pragma mark - Rise & Set

// UT = TD - DeltaT  See p. 78 of AA.

double DeltaUniversalDynamicalTimeForDate(NSDate *date)
{
	gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorianCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	NSDateComponents *components = [gregorianCalendar components:(NSYearCalendarUnit) fromDate:date];
	NSInteger year = [components year];	
	
	// See Equ. 10.1 in p.78 of AA.
	double t = ((double)year-2000.0)/100.0;
	// See Equ. 10.2 in p.78 of AA.
	double DeltaT = 102.0 + 102.0*t + 25.3*t*t;
	
	return DeltaT / 3600.0; // for UT = 0.
}

double moonTransitUTHourFractionForDateAtObservatory(NSDate *date, KPCCoordinatesComponents obsCoords)
{
	// 0h UT = midnight.
	double DeltaT = DeltaUniversalDynamicalTimeForDate(date);
    
    // TD = 0 -> UT = -DeltaT
	CFGregorianDate nullTDGregDate = gregorianUTDateForDateWithHourValue(date, -1.*DeltaT);
	double coordsJD = julianDayForGregorianDate(nullTDGregDate);
	KPCAstronomicalCoordinatesComponents moonCoords = moonCoordinatesComponentsForJulianDay(coordsJD);
	
    // At 0 UT (see AA, p102)
	CFGregorianDate nullUTGregDate = gregorianUTDateForDateWithHourValue(date, 0.0);
	double Theta0JD = julianDayForGregorianDate(nullUTGregDate);
    
    // LMST at Greenwhich.
	double Theta0 = localSiderealTimeForJulianDayLongitude(Theta0JD, 0.0)/24.0f*360.0; // Conversion in degrees.
	double L = -1*obsCoords.theta; // in AA, longitude is West Positive.
	double alpha2 = moonCoords.base.theta/24.0f*360.0;
	
	double m0 = (alpha2 + L - Theta0) / 360.0;
	return m0;
}

double H0UTHourForDateAtObservatory(NSDate *date, KPCCoordinatesComponents obsCoords)
{
	// 0h UT = midnight.
	double DeltaT = DeltaUniversalDynamicalTimeForDate(date);

    // TD = 0 -> UT = -DeltaT
    CFGregorianDate gregDate = gregorianUTDateForDateWithHourValue(date, -1.*DeltaT);
	double jd = julianDayForGregorianDate(gregDate);
	KPCAstronomicalCoordinatesComponents moonCoords = moonCoordinatesComponentsForJulianDay(jd);

	double sinh0    = sin(HorizontalParallax_h0*DEG2RAD);
	double sinphi   = sin(obsCoords.phi*DEG2RAD);
	double sindelta = sin(moonCoords.base.phi*DEG2RAD);
	double cosphi   = cos(obsCoords.phi*DEG2RAD);
	double cosdelta = cos(moonCoords.base.phi*DEG2RAD);
	
	// See Equ. 15.1 in p.102 of AA.
	double cosH0 = (sinh0 - sinphi*sindelta) / (cosphi * cosdelta);
	
	if (cosH0 < -1.0 || cosH0 > +1.0) {
		// Body is circumpolar. No rise nor set.
		return NOT_A_SCIENTIFIC_NUMBER;
	}
	
	double H0 = acos(cosH0)*RAD2DEG;
	return H0;
}

double DeltaRiseTransitSetTimeForDate(double n, NSDate *date, KPCCoordinatesComponents obsCoords)
{
	double DeltaT = DeltaUniversalDynamicalTimeForDate(date);
	CFGregorianDate gregDate = gregorianUTDateForDateWithHourValue(date, -1.*DeltaT);
	double jd = julianDayForGregorianDate(gregDate);
	
	KPCAstronomicalCoordinatesComponents moonCoords1 = moonCoordinatesComponentsForJulianDay(jd-1.0);
	KPCAstronomicalCoordinatesComponents moonCoords2 = moonCoordinatesComponentsForJulianDay(jd);
	KPCAstronomicalCoordinatesComponents moonCoords3 = moonCoordinatesComponentsForJulianDay(jd+1.0);
	
	double alpha_a = moonCoords2.base.theta - moonCoords1.base.theta;
	double alpha_b = moonCoords3.base.theta - moonCoords2.base.theta;
	double alpha_c = alpha_b - alpha_a;
	
	double alpha = moonCoords2.base.theta + n/2.0 * (alpha_a + alpha_b + n*alpha_c);
	
	double delta_a = moonCoords2.base.phi - moonCoords1.base.phi;
	double delta_b = moonCoords3.base.phi - moonCoords2.base.phi;
	double delta_c = delta_b - delta_a;
	
	double delta = moonCoords2.base.phi + n/2.0 * (delta_a + delta_b + n*delta_c);
	
	double lmst = localSiderealTimeForGregorianDateLongitude(gregDate, obsCoords.theta);
	double H = (lmst - alpha)/24.0*360.0;
	double h = KPCSkyAltitudeForJulianDayRADecLongitudeLatitude(jd, alpha, delta, obsCoords.theta, obsCoords.phi);
	
	double cosdelta = cos(delta*DEG2RAD);
	double cosphi = cos(obsCoords.phi*DEG2RAD);
	double sinH = sin(H*DEG2RAD);
	
	double Deltam = (h - HorizontalParallax_h0) / (360.0 * cosdelta * cosphi * sinH);
	return Deltam;
}

// Low-precision formula. Precision about 1% of a day, i.e.
// See also http://aa.usno.navy.mil/faq/docs/RST_defs.php

double moonRiseUTHourForDateAtObservatory(NSDate *date, KPCCoordinatesComponents obsCoords)
{
	double m0 = moonTransitUTHourFractionForDateAtObservatory(date, obsCoords);
	if (m0 == NOT_A_SCIENTIFIC_NUMBER) {
		return NOT_A_SCIENTIFIC_NUMBER;
	}
	
	double H0 = H0UTHourForDateAtObservatory(date, obsCoords);
	if (H0 == NOT_A_SCIENTIFIC_NUMBER) {
		return NOT_A_SCIENTIFIC_NUMBER;
	}
	
	double m1 = m0 - H0/360.0;
	if (m1 < 0) m1+=1;
	if (m1 > 1) m1-=1;
	
	double DeltaT = DeltaUniversalDynamicalTimeForDate(date);
	double n = m1 + DeltaT/86400.0;
	
	double Deltam = DeltaRiseTransitSetTimeForDate(n, date, obsCoords);
	
	//	NSLog(@"Raw RISE %f -> %f + Delta %f ==>> %f", m1, fmod(m1, 1.0f)*24.0f, Deltam, fmod(m1+Deltam, 1.0f)*24.0f);
	
	m1 += Deltam;
	
	return m1*24.0;//fmod(m1, 1.0)*24.0;
}

double moonSetUTHourForDateAtObservatory(NSDate *date, KPCCoordinatesComponents obsCoords)
{
	double m0 = moonTransitUTHourFractionForDateAtObservatory(date, obsCoords);
	if (m0 == NOT_A_SCIENTIFIC_NUMBER) {
		return NOT_A_SCIENTIFIC_NUMBER;
	}
	
	double H0 = H0UTHourForDateAtObservatory(date, obsCoords);
	if (H0 == NOT_A_SCIENTIFIC_NUMBER) {
		return NOT_A_SCIENTIFIC_NUMBER;
	}
	
	double m2 = m0 + H0/360.0;	
	if (m2 < 0) m2+=1;
	if (m2 > 1) m2-=1;
	
	double DeltaT = DeltaUniversalDynamicalTimeForDate(date);
	double n = m2 + DeltaT/86400.0;
	
	double Deltam = DeltaRiseTransitSetTimeForDate(n, date, obsCoords);
	
	//	NSLog(@"Raw SET %f -> %f + Delta %f ==>> %f", fmod(m2, 1.0f)*24.0f m2, fmod(m2, 1.0f)*24.0f, Deltam, fmod(m2+Deltam, 1.0f)*24.0f);
	
	m2 += Deltam;
	
	return m2*24.0;//fmod(m2, 1.0)*24.0;
}
