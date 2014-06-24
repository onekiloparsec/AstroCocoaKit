//
//  KPCSky.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import <Foundation/Foundation.h>

double KPCSkyAltitudeForJulianDayRADecLongitudeLatitude(double jd, double RA, double dec, double longitude, double latitude);
double KPCSkyAzimuthForJulianDayRADecLongitudeLatitude(double jd, double RA, double dec, double longitude, double latitude);

// Returns the airmass value corresponding to the altitude (in degrees).
double airmassForAltitude(double altitude);

// Returns the altitude value (in degrees) corresponding to the airmass.
double altitudeForAirmass(double airmass);

/**
 *  Compute the geometrical distance in parsec from the parallax.
 *
 *  @param arcseconds The parallax of an object, expressed in arcseconds.
 *
 *  @return The distance in parsecs.
 */
double parsecFromParallax(double arcseconds);

/**
 *  Compute the geometrical parallax from the distance.
 *
 *  @param parsec The distance in parsecs.
 *
 *  @return The parallax in arcseconds.
 */
double parallaxFromParsec(double parsec);

double kilometersFromParsec(double parsec);
double parsecFromKilometers(double km);

double astronomicalUnitsFromParsec(double parsec);
double parsecFromAstronomicalUnits(double ua);

double lightYearsFromParsec(double parsec);
double parsecFromLightYear(double ly);

double distanceModulusFromParsec(double parsec, double visualAbsorption);
double parsecFromDistanceModulus(double mM, double visualAbsorption);

double redshiftFromMegaParsec(double Mpc, double hubbleConstant);
double megaParsecFromRedshift(double z, double hubbleConstant);

double LorentzFactorForRadialVelocity(double kms);
double redshiftFromRadialVelocity(double kms);
double radialVelocityFromRedshift(double z);

