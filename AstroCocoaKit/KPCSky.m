//
//  KPCSky.m
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import "KPCSky.h"
#import "KPCTimes.h"
#import "KPCScientificConstants.h"

// See Equ. 13.6, p. 93 of AA.
double KPCSkyAltitudeForJulianDayRADecLongitudeLatitude(double jd, double RA, double dec, double longitude, double latitude)
{
	double hourAngle = localSiderealTimeForJulianDayLongitude(jd, longitude) - RA;

	double cosdec = cos(dec * DEG2RAD);
	double sindec = sin(dec * DEG2RAD);
	double cosha  = cos(hourAngle * HOUR2RAD);
	double coslat = cos(latitude * DEG2RAD);
	double sinlat = sin(latitude * DEG2RAD);
	
	double alt = asin(cosdec*cosha*coslat + sindec*sinlat) * RAD2DEG;
	return alt;
}

// See Equ. 13.5, p. 93 of AA.
// Azimuth is measured westward from the South (yes, South). It is a convention of astronomers not doing the same
// way of navigators and meteorologists. The reason is because we also measure hour angles from the South,
// at least in the Northern hemisphere... See AA p91, for more explanations.
double KPCSkyAzimuthForJulianDayRADecLongitudeLatitude(double jd, double RA, double dec, double longitude, double latitude)
{
	double hourAngle = localSiderealTimeForJulianDayLongitude(jd, longitude) - RA;

	double cosha  = cos(hourAngle * HOUR2RAD);
	double sinha  = sin(hourAngle * HOUR2RAD);
	double coslat = cos(latitude * DEG2RAD);
	double sinlat = sin(latitude * DEG2RAD);
	double tandec = tan(dec * DEG2RAD);

	double y = cosha*sinlat - tandec*coslat;
	double z = sinha;

	// atan2(z, y) == arctan(z/y) using the signs of both arguments to determine the quadrant of the return value.
	double az = atan2(z, y) * RAD2DEG;
	return az;
}


double airmassForAltitude(double altitude)
{
	return 1./cos(M_PI_2 - altitude*DEG2RAD);
}

double altitudeForAirmass(double airmass)
{
	return 90. - acos(1./airmass)*RAD2DEG;
}


// see http://www.astro.soton.ac.uk/~td/luminosity_convert.html

double parsecFromParallax(double arcseconds) {
    return 1. / tan(arcseconds / 3600.0 * M_PI / 180.) / PC2UA;
}

double parallaxFromParsec(double parsec) {
    return atan(1./ (parsec * PC2UA)) * 3600.0 * 180.0 / M_PI;
}

double kilometersFromParsec(double parsec)
{
	return astronomicalUnitsFromParsec(parsec) * UA2KM;
}

double parsecFromKilometers(double km)
{
	return parsecFromAstronomicalUnits(km / UA2KM);
}

double astronomicalUnitsFromParsec(double parsec)
{
	return parsec * PC2UA;
}

double parsecFromAstronomicalUnits(double ua)
{
	return ua / PC2UA;
}

double lightYearsFromParsec(double parsec)
{
	return parsec * PC2LY;
}

double parsecFromLightYear(double ly)
{
    return ly / PC2LY;
}

double distanceModulusFromParsec(double parsec, double visualAbsorption)
{
	return 5.0 * log10(parsec) - 5.0 + visualAbsorption;
}

double parsecFromDistanceModulus(double mM, double visualAbsorption)
{
    return pow(10.0, (mM + 5.0 - visualAbsorption)/5.0);
}

double redshiftFromMegaParsec(double Mpc, double hubbleConstant)
{
	return Mpc * hubbleConstant / SPEED_OF_LIGHT_KMS;
}

double megaParsecFromRedshift(double z, double hubbleConstant)
{
    return z * SPEED_OF_LIGHT_KMS / hubbleConstant;
}

double LorentzFactorForRadialVelocity(double kms)
{
    return 1./pow(1.0 - kms*kms/SPEED_OF_LIGHT_KMS/SPEED_OF_LIGHT_KMS, 0.5);
}

// 1+z = (1+v/c)*gamma;
double redshiftFromRadialVelocity(double kms)
{
    return (1.0 + kms/SPEED_OF_LIGHT_KMS)*LorentzFactorForRadialVelocity(kms) - 1.0;
}

double radialVelocityFromRedshift(double z)
{
    double A = pow(1.0 + z, 2.0);
    return SPEED_OF_LIGHT_KMS * (A - 1.0) / (A + 1.0);
}

