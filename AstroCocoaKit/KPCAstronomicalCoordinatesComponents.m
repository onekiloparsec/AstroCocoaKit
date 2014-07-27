//
//  KPCAstronomicalCoordinatesComponents.m
//
//  Created by onekiloparsec on 26/10/13.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import "KPCAstronomicalCoordinatesComponents.h"
#import "KPCScientificConstants.h"
#import "KPCTimes.h"

double KPCJulianEpochStandard(void)
{
	return STANDARD_JULIAN_EPOCH;
}

double KPCJulianEpochCurrent(void)
{
	double jd = julianDayForDate([NSDate date]);
	return STANDARD_JULIAN_EPOCH + (jd - J2000)/AVERAGE_JULIAN_YEAR;
}

double KPCJulianEpochB1950(void)
{
	return STANDARD_JULIAN_EPOCH + (JULIAN_DAY_B1950_0 - J2000)/AVERAGE_JULIAN_YEAR;
}

NSString *positionAngleString(double value)
{
    value = fmod(value + 360.0, 360.0);
    
	NSString *s = nil;
	if (value > 337.5 || value <= 22.5) {
		s = @"N";
	}
	else if (value > 22.5 && value <= 67.5) {
		s = @"NE";
	}
	else if (value > 67.5 && value <= 112.5) {
		s = @"E";
	}
	else if (value > 112.5 && value <= 157.5) {
		s = @"SE";
	}
	else if (value > 157.5 && value <= 202.5) {
		s = @"S";
	}
	else if (value > 202.5 && value <= 247.5) {
		s = @"SW";
	}
	else if (value > 247.5 && value <= 292.5) {
		s = @"W";
	}
	else if (value > 292.5 && value <= 337.5) {
		s = @"NW";
	}
	else {
		s = @"?";
	}
    
	return s;
}

NSString *shortPositionAngleString(double value)
{
	return [NSString stringWithFormat:@"PA %.0fº - %@",
			value, shortPositionAngleString(value)];
}

NSString *separationAngleString(double value)
{
	if (value >= 10.0) {
		return [NSString stringWithFormat:@"%.0fº", value];
	}
	else if (value >= 2.0 && value < 10.0) {
		return [NSString stringWithFormat:@"%.1fº", value];
	}
	else if (value >= 0.5 && value < 2.0) {
		return [NSString stringWithFormat:@"%.2fº", value];
	}
	else if (value >= 0.1 && value < 0.5) {
		return [NSString stringWithFormat:@"%.1f'", value*60];
	}
	else if (value >= 0.01 && value < 0.1) {
		return [NSString stringWithFormat:@"%.2f'", value*60];
	}
	else {
		return [NSString stringWithFormat:@"%.2f'", value*60];
	}
}

NSString *KPCAstronomicalCoordinatesSystemName(KPCAstronomicalCoordinatesSystem system)
{
	if (system == KPCAstronomicalCoordinatesSystemEquatorial) {
		return @"equatorial";
	}
	else if (system == KPCAstronomicalCoordinatesSystemCelestial) {
		return @"celestial";
	}
	else if (system == KPCAstronomicalCoordinatesSystemGalactic) {
		return @"galactic";
	}

	return @"";
}

// See AA, p. 147
double KPCEclipticObliquityForEpoch(double epoch)
{
	double T = julianCenturyForJulianDay(julianDayForEpoch(epoch));
	double U = T / 100.0;

	double epsilon0 = ECLIPTIC_OBLIQUITY_J2000_0
	- 4680.93 * ARCSEC2DEG * U
	-    1.55 * ARCSEC2DEG * pow(U, 2.0)
	+ 1999.25 * ARCSEC2DEG * pow(U, 3.0)
	-   51.38 * ARCSEC2DEG * pow(U, 4.0)
	-  249.67 * ARCSEC2DEG * pow(U, 5.0)
	-   39.05 * ARCSEC2DEG * pow(U, 6.0)
	+    7.12 * ARCSEC2DEG * pow(U, 7.0)
	+   27.87 * ARCSEC2DEG * pow(U, 8.0)
	+    5.79 * ARCSEC2DEG * pow(U, 9.0)
	+    2.45 * ARCSEC2DEG * pow(U, 10.0);

	return epsilon0;
}

void KPCCopyAstronomicalCoordinatesComponents(KPCAstronomicalCoordinatesComponents *input, KPCAstronomicalCoordinatesComponents *output)
{
	(*output).base.theta = (*input).base.theta;
	(*output).base.phi   = (*input).base.phi;
	(*output).base.units = (*input).base.units;
	(*output).epoch  = (*input).epoch;
	(*output).system = (*input).system;
}

KPCAstronomicalCoordinatesComponents KPCMakeAstronomicalCoordinatesComponents(double v1, double v2, KPCCoordinatesUnits units, double epoch, KPCAstronomicalCoordinatesSystem system)
{
	KPCCoordinatesComponents base;
	base.theta = v1;
	base.phi   = v2;
	base.units = units;

	KPCAstronomicalCoordinatesComponents components;
	components.base   = base;
	components.epoch  = epoch;
	components.system = system;

	return components;
}

void KPCPrecessEquatorialCoordinatesComponents(KPCAstronomicalCoordinatesComponents *input, KPCAstronomicalCoordinatesComponents *output, double finalEpoch)
{
	if ((*input).system != KPCAstronomicalCoordinatesSystemEquatorial) {
		[NSException raise:NSInvalidArgumentException format:@"Wrong input system. Must always be equatorial"];
	}

	if ((*input).epoch == finalEpoch) {
		KPCCopyAstronomicalCoordinatesComponents(&(*input), &(*output));
		return;
	}

	double startingEpoch = (*input).epoch;
	double JD0 = J2000 + (startingEpoch - STANDARD_JULIAN_EPOCH) * JULIAN_YEAR;
	double JD  = J2000 + (finalEpoch - STANDARD_JULIAN_EPOCH) * JULIAN_YEAR;

	double T = (JD0 - J2000)/(JULIAN_YEAR * 100.);
	double t = (JD - JD0)/(JULIAN_YEAR * 100.);

	double zeta  = (2306.2181 + 1.39656*T - 0.000139*T*T) * t + (0.30188 - 0.000344*T) * t*t + 0.017998 * t*t*t;
	double z	 = (2306.2181 + 1.39656*T - 0.000139*T*T) * t + (1.09468 + 0.000066*T) * t*t + 0.018203 * t*t*t;
	double theta = (2004.3109 - 0.85330*T - 0.000217*T*T) * t - (0.42665 + 0.000217*T) * t*t - 0.041833 * t*t*t;

	zeta  = zeta * ARCSEC2RAD;
	z     = z * ARCSEC2RAD;
	theta = theta * ARCSEC2RAD;

	KPCCoordinatesComponents newBase;
	KPCTransformCoordinatesComponentsUnits(&(*input).base, &newBase, KPCCoordinatesUnitsRadians);

	double RA = newBase.theta;
	double Dec = newBase.phi;

	double A = cos(Dec) * sin(RA + zeta);
	double B = cos(theta) * cos(Dec) * cos(RA + zeta) - sin(theta) * sin(Dec);
	double C = sin(theta) * cos(Dec) * cos(RA + zeta) + cos(theta) * sin(Dec);

	// atan2(y, x) = arc tangeant of y/x.
	double newRA  = atan2(A, B) + z;	// Result in radians.
	double newDec = asin(C);			// Result in radians.

	if (newRA < 0.0) { newRA += 2.0*M_PI; }

	(*output).base.theta = newRA;
	(*output).base.phi = newDec;
	(*output).base.units = KPCCoordinatesUnitsRadians;
	(*output).epoch = finalEpoch;
	(*output).system = KPCAstronomicalCoordinatesSystemEquatorial;

	KPCCoordinatesComponents finalBase;
	KPCTransformCoordinatesComponentsUnits(&(*output).base, &finalBase, (*input).base.units);
	(*output).base = finalBase;
}

#pragma mark - Galactic

// WE ASSUME EPOCH = B1950 or J2000;
double KPCGalacticLongitudeFromEquatorialComponents(KPCCoordinatesComponents *base, double epoch)
{
	if (epoch == KPCJulianEpochStandard() || epoch == KPCJulianEpochB1950()) {
		[NSException raise:NSInvalidArgumentException
					format:@"Wrong input epoch. Must be either KPCJulianEpochStandard() or KPCJulianEpochB1950()"];
	}

	KPCCoordinatesComponents newBase;
	KPCTransformCoordinatesComponentsUnits(base, &newBase, KPCCoordinatesUnitsRadians);
	if (newBase.units == KPCCoordinatesUnitsUndefined) {
		return NOT_A_SCIENTIFIC_NUMBER;
	}

	double rightAscension = newBase.theta;
	double declination = newBase.phi;

	BOOL useJ200Epoch = (epoch == J2000);
	double poleAlpha = (useJ200Epoch) ? GALACTIC_NORTH_POLE_ALPHA_J2000_0 : GALACTIC_NORTH_POLE_ALPHA_B1950_0;
	double poleDelta = (useJ200Epoch) ? GALACTIC_NORTH_POLE_DELTA_J2000_0 : GALACTIC_NORTH_POLE_DELTA_B1950_0;

	double A = sin(poleAlpha*DEG2RAD - rightAscension);
	double B = cos(poleAlpha*DEG2RAD - rightAscension);
	double C = sin(poleDelta*DEG2RAD);
	double D = tan(declination*DEG2RAD);
	double E = cos(poleDelta*DEG2RAD);

	double numerator = A;
	double denominator = B*C - D*E;

	double x = atan2(numerator, denominator) * RAD2DEG;
	double l = 303.0 - x;

	while (l < 0.0) { l += 360.0; }
	while (l >= 360.0) { l -= 360.0; }

	return l;
}

// WE ASSUME EPOCH = B1950 or J2000;
double KPCGalacticLatitudeFromEquatorialComponents(KPCCoordinatesComponents *base, double epoch)
{
	NSCAssert(epoch == KPCJulianEpochStandard() || epoch == KPCJulianEpochB1950(), @"Wrong epoch");

	KPCCoordinatesComponents newBase;
	KPCTransformCoordinatesComponentsUnits(base, &newBase, KPCCoordinatesUnitsRadians);
	if (newBase.units == KPCCoordinatesUnitsUndefined) {
		return NOT_A_SCIENTIFIC_NUMBER;
	}

	double rightAscension = newBase.theta;
	double declination = newBase.phi;

	BOOL useJ200Epoch = (epoch == J2000);
	double poleAlpha = (useJ200Epoch) ? GALACTIC_NORTH_POLE_ALPHA_J2000_0 : GALACTIC_NORTH_POLE_ALPHA_B1950_0;
	double poleDelta = (useJ200Epoch) ? GALACTIC_NORTH_POLE_DELTA_J2000_0 : GALACTIC_NORTH_POLE_DELTA_B1950_0;

	double A = sin(declination);
	double B = sin(poleDelta*DEG2RAD);
	double C = cos(declination);
	double D = cos(poleDelta*DEG2RAD);
	double E = cos(poleAlpha*DEG2RAD - rightAscension);

	double sinB = A*B + C*D*E;
	return asin(sinB) * RAD2DEG;
}

void KPCGalacticComponentsFromEquatorialComponents(KPCAstronomicalCoordinatesComponents *inComponents,
												   KPCAstronomicalCoordinatesComponents *outComponents)
{
	NSCAssert((*inComponents).system == KPCAstronomicalCoordinatesSystemEquatorial, @"Wrong system");
	NSCAssert((*inComponents).epoch == KPCJulianEpochB1950() || (*inComponents).epoch == KPCJulianEpochStandard(), @"Wrong epoch");

	(*outComponents).system = KPCAstronomicalCoordinatesSystemGalactic;
	(*outComponents).epoch = (*inComponents).epoch;
	(*outComponents).base.units = KPCCoordinatesUnitsDegrees;

	(*outComponents).base.theta = KPCGalacticLongitudeFromEquatorialComponents(&(*inComponents).base, (*inComponents).epoch);
	(*outComponents).base.phi = KPCGalacticLatitudeFromEquatorialComponents(&(*inComponents).base, (*inComponents).epoch);
}

#pragma mark - Celestial

double KPCCelestialLongitudeFromEquatorialComponents(KPCCoordinatesComponents *base, double epoch)
{
	KPCCoordinatesComponents newBase;
	KPCTransformCoordinatesComponentsUnits(base, &newBase, KPCCoordinatesUnitsRadians);
	if (newBase.units == KPCCoordinatesUnitsUndefined) {
		return NOT_A_SCIENTIFIC_NUMBER;
	}

	double rightAscension = newBase.theta;
	double declination = newBase.phi;

	double obliquity  = KPCEclipticObliquityForEpoch(epoch);
	double cosEpsilon = cos(obliquity*DEG2RAD);
	double sinEpsilon = sin(obliquity*DEG2RAD);

	double sinAlpha = sin(rightAscension);
	double cosAlpha = cos(rightAscension);
	double tanDelta = tan(declination);

	double lambda = atan2((sinAlpha * cosEpsilon + tanDelta * sinEpsilon), cosAlpha);
	if (lambda < 0) lambda += 2*M_PI;

	return lambda * RAD2DEG;

}

double KPCCelestialLatitudeFromEquatorialComponents(KPCCoordinatesComponents *base, double epoch)
{
	KPCCoordinatesComponents newBase;
	KPCTransformCoordinatesComponentsUnits(base, &newBase, KPCCoordinatesUnitsRadians);
	if (newBase.units == KPCCoordinatesUnitsUndefined) {
		return NOT_A_SCIENTIFIC_NUMBER;
	}

	double rightAscension = newBase.theta;
	double declination = newBase.phi;

	double obliquity  = KPCEclipticObliquityForEpoch(epoch);
	double cosEpsilon = cos(obliquity*DEG2RAD);
	double sinEpsilon = sin(obliquity*DEG2RAD);

	double sinDelta = sin(declination);
	double cosDelta = cos(declination);
	double sinAlpha = sin(rightAscension);

	double sinBeta = sinDelta * cosEpsilon - cosDelta * sinEpsilon * sinAlpha;

	return asin(sinBeta) * RAD2DEG;
}

void KPCCelestialComponentsFromEquatorialComponents(KPCAstronomicalCoordinatesComponents *inComponents,
													KPCAstronomicalCoordinatesComponents *outComponents)
{
	NSCAssert((*inComponents).system == KPCAstronomicalCoordinatesSystemEquatorial, @"Wrong system");

	KPCAstronomicalCoordinatesComponents outputComponents;
	outputComponents.system = KPCAstronomicalCoordinatesSystemCelestial;
	outputComponents.epoch = (*inComponents).epoch;
	outputComponents.base.units = KPCCoordinatesUnitsDegrees;

	(*outComponents).base.theta = KPCCelestialLongitudeFromEquatorialComponents(&(*inComponents).base, (*inComponents).epoch);
	(*outComponents).base.phi = KPCCelestialLatitudeFromEquatorialComponents(&(*inComponents).base, (*inComponents).epoch);
}


#pragma mark - Transform Equatorial

void KPCTransformEquatorialCoordinatesComponents(KPCAstronomicalCoordinatesComponents *inComponents,
												 KPCAstronomicalCoordinatesComponents *outComponents,
												 KPCAstronomicalCoordinatesSystem outputSystem)
{
	NSCAssert((*inComponents).system == KPCAstronomicalCoordinatesSystemEquatorial, @"Wrong system");

	if (outputSystem == (*inComponents).system) {
		return KPCCopyAstronomicalCoordinatesComponents(inComponents, outComponents);
	}

	switch (outputSystem) {
		case KPCAstronomicalCoordinatesSystemGalactic:
			KPCGalacticComponentsFromEquatorialComponents(inComponents, outComponents);
			break;

		case KPCAstronomicalCoordinatesSystemCelestial:
			KPCCelestialComponentsFromEquatorialComponents(inComponents, outComponents);
			break;

		default:
			break;
	}
}

void KPCEquatorialComponentsFromGalacticLongitudeLatitude(KPCCoordinatesComponents *components,
														  double l,
														  double b,
														  double epoch)
{
	NSCAssert(epoch == J2000 || epoch == KPCJulianEpochB1950(), @"Wrong epoch");

	BOOL useJ200Epoch = (epoch == J2000);
//	double poleAlpha = (useJ200Epoch) ? GALACTIC_NORTH_POLE_ALPHA_J2000_0 : GALACTIC_NORTH_POLE_ALPHA_B1950_0;
	double poleDelta = (useJ200Epoch) ? GALACTIC_NORTH_POLE_DELTA_J2000_0 : GALACTIC_NORTH_POLE_DELTA_B1950_0;

	double A = sin((l - 123.0)*DEG2RAD);
	double B = cos((l - 123.0)*DEG2RAD);
	double C = sin(poleDelta*DEG2RAD);
	double D = tan(b*DEG2RAD);
	double E = cos(poleDelta*DEG2RAD);

	double numerator = A;
	double denominator = B*C - D*E;
	double theta = atan2(numerator, denominator) + 12.25*DEG2RAD;
	theta = fmod(theta+M_PI*2, M_PI*2);

	A = sin(b*DEG2RAD);
	B = sin(poleDelta*DEG2RAD);
	C = cos(b*DEG2RAD);
	D = cos(poleDelta*DEG2RAD);
	E = cos((l-123.0)*DEG2RAD);

	double sinDelta = A*B + C*D*E;
	double phi = asin(sinDelta);

	if (phi < -1*M_PI/2.0) { phi += M_PI; }
	if (phi > M_PI/2.0) { phi -= M_PI;	}

	double rightAscension = theta * RAD2HOUR;
	double declination = phi * RAD2DEG;

	(*components).units = KPCCoordinatesUnitsHoursAndDegrees;
	(*components).theta = rightAscension;
	(*components).phi = declination;
}

void KPCEquatorialComponentsFromCelestialLongitudeLatitude(KPCCoordinatesComponents *components,
														   double lambda,
														   double beta,
														   double epoch)
{
	double obliquity  = KPCEclipticObliquityForEpoch(epoch);
	double cosEpsilon = cos(obliquity*DEG2RAD);
	double sinEpsilon = sin(obliquity*DEG2RAD);

	double alphaX = sin(lambda*DEG2RAD)*cosEpsilon - tan(beta*DEG2RAD)*sinEpsilon;
	double alphaY = cos(lambda*DEG2RAD);

	double rightAscension = atan2(alphaX, alphaY)*RAD2HOUR;

	double sinDelta = sin(beta*DEG2RAD)*cosEpsilon + cos(beta*DEG2RAD)*sinEpsilon*sin(lambda*DEG2RAD);
	double declination = asin(sinDelta)*RAD2DEG;

	(*components).units = KPCCoordinatesUnitsHoursAndDegrees;
	(*components).theta = rightAscension;
	(*components).phi = declination;
}


void KPCTransformToEquatorialCoordinatesComponents(KPCAstronomicalCoordinatesComponents *inComponents,
												   KPCAstronomicalCoordinatesComponents *outComponents)
{
	if ((*inComponents).system == KPCAstronomicalCoordinatesSystemEquatorial) {
		return KPCCopyAstronomicalCoordinatesComponents(inComponents, outComponents);
	}

	(*outComponents).system = KPCAstronomicalCoordinatesSystemEquatorial;
	(*outComponents).epoch = (*inComponents).epoch;

	// We'll always use an input in degrees.
	KPCCoordinatesComponents newBase;
	KPCTransformCoordinatesComponentsUnits(&(*inComponents).base, &newBase, KPCCoordinatesUnitsDegrees);

	switch ((*inComponents).system) {
		case KPCAstronomicalCoordinatesSystemGalactic:
			KPCEquatorialComponentsFromGalacticLongitudeLatitude(&(*outComponents).base,
																 newBase.theta,
																 newBase.phi,
																 (*inComponents).epoch);
			break;

		case KPCAstronomicalCoordinatesSystemCelestial:
			KPCEquatorialComponentsFromCelestialLongitudeLatitude(&(*outComponents).base,
																  newBase.theta,
																  newBase.phi,
																  (*inComponents).epoch);
			break;

		default:
			break;
	}
}
