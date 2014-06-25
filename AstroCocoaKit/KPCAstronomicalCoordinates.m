//
//  STLAstronomicalCoordinates.m
//  iObserve
//
//  Created by Soft Tenebras Lux on 16/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalCoordinates.h"
#import "KPCAstronomicalCoordinates+Labels.h"
#import "KPCTerrestrialCoordinates.h"
#import "KPCScientificConstants.h"

@interface KPCAstronomicalCoordinates () {
	KPCAstronomicalCoordinatesSystem _system;
	double _epoch;
}
@end

@implementation KPCAstronomicalCoordinates

- (id)init
{
	self = [super init];
	if (self) {
		_epoch = STANDARD_JULIAN_EPOCH;
		_system = KPCAstronomicalCoordinatesSystemEquatorial;
		_displayedEpoch = _epoch;
		_displayedSystem = _system;
	}
	return self;
}

- (id)initWithFirstValue:(double)v1
			 secondValue:(double)v2
				   units:(KPCCoordinatesUnits)units
				inSystem:(KPCAstronomicalCoordinatesSystem)system
				 atEpoch:(double)epoch
{
	self = [super initWithTheta:v1 phi:v2 units:units];
	if (self) {
		_epoch = epoch;
		_system = system;
		_displayedEpoch = _epoch;
		_displayedSystem = _system;
		self.displayedUnits = KPCCoordinatesUnitsHoursAndDegrees;
	}
	return self;
}

+ (KPCAstronomicalCoordinates *)coordinatesWithComponents:(KPCAstronomicalCoordinatesComponents)components;
{
	KPCAstronomicalCoordinates *result = nil;
	switch (components.system) {
		case KPCAstronomicalCoordinatesSystemEquatorial: {
			KPCCoordinatesComponents newBase;
			KPCTransformCoordinatesComponentsUnits(&components.base, &newBase, KPCCoordinatesUnitsHoursAndDegrees);
			result = [KPCAstronomicalCoordinates coordinatesWithRightAscension:newBase.theta declination:newBase.phi epoch:components.epoch];
		}
			break;

		case KPCAstronomicalCoordinatesSystemCelestial: {
			KPCCoordinatesComponents newBase;
			KPCTransformCoordinatesComponentsUnits(&components.base, &newBase, KPCCoordinatesUnitsDegrees);
			result = [KPCAstronomicalCoordinates coordinatesWithCelestialLongitude:newBase.theta latitude:newBase.phi epoch:components.epoch];
		}
			break;

		case KPCAstronomicalCoordinatesSystemGalactic: {
			KPCCoordinatesComponents newBase;
			KPCTransformCoordinatesComponentsUnits(&components.base, &newBase, KPCCoordinatesUnitsDegrees);
			result = [KPCAstronomicalCoordinates coordinatesWithGalacticLongitude:newBase.theta latitude:newBase.phi epoch:components.epoch];
		}
			break;

		default:
			break;
	}
	return result;
}

- (BOOL)isEqual:(id)object
{
	if ([object isKindOfClass:[KPCAstronomicalCoordinates class]] == NO) {
		return NO;
	}
	KPCAstronomicalCoordinates *other = (KPCAstronomicalCoordinates *)object;
	if ([self areEmpty] || [other areEmpty]) {
		return NO;
	}

	BOOL condition1 = (fabs(self.rightAscension - other.rightAscension) < 1e-9);
	BOOL condition2 = (fabs(self.declination - other.declination) < 1e-9);

	return condition1 && condition2 && ([self epoch] == [other epoch]);
}



#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		_epoch = [[coder decodeObjectForKey:@"epoch"] doubleValue];
		_system = [[coder decodeObjectForKey:@"system"] unsignedIntegerValue];

		if ([coder containsValueForKey:@"displayedEpoch"]) {
			_displayedEpoch = [[coder decodeObjectForKey:@"displayedEpoch"] doubleValue];;
		}
		else {
			_displayedEpoch = _epoch;
		}

		if ([coder containsValueForKey:@"displayedSystem"]) {
			_displayedSystem = [[coder decodeObjectForKey:@"displayedSystem"] unsignedIntegerValue];;
		}
		else {
			_displayedSystem = _system;
		}
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];
	[coder encodeObject:@(_epoch) forKey:@"epoch"];
	[coder encodeObject:@(_system) forKey:@"system"];
	[coder encodeObject:@(_displayedEpoch) forKey:@"displayedEpoch"];
	[coder encodeObject:@(_displayedSystem) forKey:@"displayedSystem"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    KPCAstronomicalCoordinates *newCoords = [[KPCAstronomicalCoordinates allocWithZone:zone] initWithRightAscension:self.rightAscension
																										declination:self.declination
																											  epoch:self.epoch];

	newCoords.displayedUnits = self.displayedUnits;
	newCoords.displayedEpoch = self.displayedEpoch;
	newCoords.displayedSystem = self.displayedSystem;

	return newCoords;
}

#pragma mark - Accessors

- (double)epoch
{
	return _epoch;
}

- (KPCAstronomicalCoordinatesSystem)system
{
	return _system;
}

- (NSString *)systemName
{
	return KPCAstronomicalCoordinatesSystemName(self.system);
}

- (double)firstValueForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	double value = NOT_A_SCIENTIFIC_NUMBER;
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			value = [self rightAscension];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			value = [self celestialLongitude];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			value = [self galacticLongitude];
			break;
		default:
			break;
	}
	return value;
}

- (double)secondValueForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	double value = NOT_A_SCIENTIFIC_NUMBER;
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			value = [self declination];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			value = [self celestialLatitude];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			value = [self galacticLatitude];
			break;
		default:
			break;
	}
	return value;
}

- (NSString *)firstValueStringForSystem:(KPCAstronomicalCoordinatesSystem)system withUnits:(KPCCoordinatesUnits)units
{
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			return [self rightAscensionStringWithUnits:units];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			return [self celestialLongitudeStringWithUnits:units];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			return [self galacticLongitudeStringWithUnits:units];
			break;
		default:
			return @"?";
			break;
	}
}

- (NSString *)secondValueStringForSystem:(KPCAstronomicalCoordinatesSystem)system withUnits:(KPCCoordinatesUnits)units
{
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			return [self declinationStringWithUnits:units];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			return [self celestialLatitudeStringWithUnits:units];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			return [self galacticLatitudeStringWithUnits:units];
			break;
		default:
			return @"?";
			break;
	}
}

- (KPCCoordinatesComponents)componentsForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	KPCCoordinatesComponents components;
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			components.theta = self.rightAscension;
			components.phi = self.declination;
			components.units = KPCCoordinatesUnitsHoursAndDegrees;
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			components.theta = self.celestialLongitude;
			components.phi = self.celestialLatitude;
			components.units = KPCCoordinatesUnitsDegrees;
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			components.theta = self.galacticLongitude;
			components.phi = self.galacticLatitude;
			components.units = KPCCoordinatesUnitsDegrees;
			break;
		case KPCAstronomicalCoordinatesSystemLocalHorizontal:
			components.theta = NOT_A_SCIENTIFIC_NUMBER;
			components.phi = NOT_A_SCIENTIFIC_NUMBER;
			components.units = KPCCoordinatesUnitsUndefined;
			break;
		default:
			break;
	}
	return components;
}


#pragma mark - Equatorial

- (id)initWithRightAscension:(double)hours declination:(double)degrees epoch:(double)epoch
{
	self = [super initWithTheta:hours*HOUR2RAD phi:degrees*DEG2RAD units:KPCCoordinatesUnitsRadians];
	if (self) {
		_epoch = epoch;
		_system = KPCAstronomicalCoordinatesSystemEquatorial;
		_displayedEpoch = _epoch;
		_displayedSystem = _system;
		self.displayedUnits = KPCCoordinatesUnitsHoursAndDegrees;
	}
	return self;
}

+ (KPCAstronomicalCoordinates *)coordinatesWithRightAscension:(double)hours declination:(double)degrees
{
	return [[KPCAstronomicalCoordinates alloc] initWithRightAscension:hours declination:degrees epoch:STANDARD_JULIAN_EPOCH];
}

+ (KPCAstronomicalCoordinates *)coordinatesWithRightAscension:(double)hours declination:(double)degrees epoch:(double)epoch
{
	return [[KPCAstronomicalCoordinates alloc] initWithRightAscension:hours declination:degrees epoch:epoch];
}

+ (KPCAstronomicalCoordinates *)coordinatesWithRightAscensionElements:(NSArray *)ra declinationElements:(NSArray *)dec
{
	NSAssert(ra, @"Missing RA array.");
	NSAssert(dec, @"Missing Dec array.");
	NSAssert([ra count] == 3, @"Wrong number of RA elements.");
	NSAssert([dec count] == 3, @"Wrong number of Dec elements.");

	KPCSexagesimalComponents raComponents = KPCMakeSexagesimalComponentsFromArray(ra);
	KPCSexagesimalComponents decComponents = KPCMakeSexagesimalComponentsFromArray(dec);

	double hours = KPCSexagesimalComponentsValue(raComponents);
	double degrees = KPCSexagesimalComponentsValue(decComponents);

	return [[KPCAstronomicalCoordinates alloc] initWithRightAscension:hours declination:degrees epoch:STANDARD_JULIAN_EPOCH];
}


// Historical note: RA and Dec are always stored as RADIANS inside Theta and Phi respectively.

- (double)rightAscension
{
	return self.theta * RAD2HOUR;;
}

- (double)declination
{
	return self.phi * RAD2DEG;
}

- (NSString *)rightAscensionString
{
	return [self rightAscensionStringWithUnits:self.displayedUnits];
}

- (NSString *)declinationString
{
	return [self declinationStringWithUnits:self.displayedUnits];
}

- (NSString *)rightAscensionStringWithUnits:(KPCCoordinatesUnits)units
{
	return [self valueString:self.rightAscension withUnits:units inHours:YES];
}

- (NSString *)declinationStringWithUnits:(KPCCoordinatesUnits)units
{
	return [self valueString:self.declination withUnits:units inHours:NO];
}

#pragma mark - Celestial

+ (KPCAstronomicalCoordinates *)coordinatesWithCelestialLongitude:(double)lambda latitude:(double)beta
{
	return [KPCAstronomicalCoordinates coordinatesWithCelestialLongitude:lambda latitude:beta epoch:STANDARD_JULIAN_EPOCH];
}

+ (KPCAstronomicalCoordinates *)coordinatesWithCelestialLongitude:(double)lambda latitude:(double)beta epoch:(double)epoch
{
	KPCCoordinatesComponents components;
	KPCEquatorialComponentsFromCelestialLongitudeLatitude(&components, lambda, beta, epoch);

	return [[KPCAstronomicalCoordinates alloc] initWithRightAscension:components.theta
														  declination:components.phi
																epoch:epoch];
}

// See p.93 of AA.
- (double)celestialLongitude
{
	KPCCoordinatesComponents components = [self componentsForSystem:KPCAstronomicalCoordinatesSystemEquatorial];
	return KPCCelestialLongitudeFromEquatorialComponents(&components, _epoch);
}

- (double)celestialLatitude
{
	KPCCoordinatesComponents components = [self componentsForSystem:KPCAstronomicalCoordinatesSystemEquatorial];
	return KPCCelestialLatitudeFromEquatorialComponents(&components, _epoch);
}

- (NSString *)celestialLongitudeString
{
	return [self celestialLongitudeStringWithUnits:[self units]];
}

- (NSString *)celestialLatitudeString
{
	return [self celestialLatitudeStringWithUnits:[self units]];
}

- (NSString *)celestialLongitudeStringWithUnits:(KPCCoordinatesUnits)units
{
	return [self valueString:self.celestialLongitude withUnits:units inHours:NO];
}

- (NSString *)celestialLatitudeStringWithUnits:(KPCCoordinatesUnits)units
{
	return [self valueString:self.celestialLatitude withUnits:units inHours:NO];
}

- (NSArray *)celestialLongitudeStringElements
{
	return [@(self.celestialLongitude) sexagesimalComponentsStrings];
}

- (NSArray *)celestialLatitudeStringElements
{
	return [@(self.celestialLatitude) sexagesimalComponentsStrings];
}

#pragma mark - Galactic

+ (KPCAstronomicalCoordinates *)coordinatesWithGalacticLongitude:(double)l latitude:(double)b
{
	return [KPCAstronomicalCoordinates coordinatesWithGalacticLongitude:l latitude:b epoch:STANDARD_JULIAN_EPOCH];
}

+ (KPCAstronomicalCoordinates *)coordinatesWithGalacticLongitude:(double)l latitude:(double)b epoch:(double)epoch
{
	KPCCoordinatesComponents components;
	KPCEquatorialComponentsFromGalacticLongitudeLatitude(&components, l, b, epoch);

	return [[KPCAstronomicalCoordinates alloc] initWithRightAscension:components.theta
														  declination:components.phi
																epoch:epoch];
}

#pragma mark - Galactic Accessors

/*
- (double)galacticLongitudePAPER
{
	NSAssert(self.epoch == KPCJulianEpochStandard() ||
			 self.epoch == KPCJulianEpochB1950(),
			 @"Wrong epoch");

	BOOL stdEpoch = self.epoch == KPCJulianEpochStandard();

	double alpha0 = (stdEpoch) ? 282.86 : 282.25;
	double l0 = (stdEpoch) ? 32.93 : 33.0;

	double cosdelta = cos(self.declination*DEG2RAD);
	double cosb = cos([self galacticLatitude]*DEG2RAD);
	double cosalphaminusalpha0 = cos(self.rightAscension*HOUR2RAD - alpha0*DEG2RAD);
	double coslminusl0 = cosalphaminusalpha0 * cosdelta / cosb;

	double lminusl0 = acos(coslminusl0) * RAD2DEG;
	double l = lminusl0 + l0 + 180;

	if (l < 0.0) {
		l += 360.0;
	}

//	double deltaNPG = (stdEpoch) ? 27.13 : 27.4;
//	double sindelta = sin(self.declination*DEG2RAD);
//	double cosdeltaNPG = cos(deltaNPG*DEG2RAD);
//	double sindeltaNPG = sin(deltaNPG*DEG2RAD);
//	double sinalphaminusalpha0 = sin(self.rightAscension*HOUR2RAD - alpha0*DEG2RAD);
//
//	double sinlminusl0 = (sindelta*cosdeltaNPG + cosdelta*sindeltaNPG*sinalphaminusalpha0) / cosb;
//	double lminusl0_2 = asin(sinlminusl0) * RAD2DEG;
//	double l_2 = lminusl0_2 + l0;

	return l;
}

- (double)galacticLatitudePAPER
{
	NSAssert(self.epoch == KPCJulianEpochStandard() ||
			 self.epoch == KPCJulianEpochB1950(),
			 @"Wrong epoch");

	BOOL stdEpoch = (self.epoch == KPCJulianEpochStandard());

	double alpha0 = (stdEpoch) ? 282.86 : 282.25;
	double deltaNPG = (stdEpoch) ? 27.13 : 27.4;

	double sindelta = sin(self.declination*DEG2RAD);
	double sindeltaNPG = sin(deltaNPG*DEG2RAD);
	double cosdelta = cos(self.declination*DEG2RAD);
	double cosdeltaNPG = cos(deltaNPG*DEG2RAD);
	double sinalphaminusalpha0 = sin(self.rightAscension*HOUR2RAD - alpha0*DEG2RAD);

	double sinb = sindelta * sindeltaNPG - cosdelta * cosdeltaNPG * sinalphaminusalpha0;
	return asin(sinb) * RAD2DEG;
}
*/

// See Equations in AA, p. 94. Input in degrees.
- (double)galacticLongitude
{
	NSAssert(self.epoch == KPCJulianEpochStandard() || self.epoch == KPCJulianEpochB1950(), @"Wrong epoch");
	KPCCoordinatesComponents components = [self componentsForSystem:KPCAstronomicalCoordinatesSystemEquatorial];
	return KPCGalacticLongitudeFromEquatorialComponents(&components, _epoch);
}

- (double)galacticLatitude
{
	NSAssert(self.epoch == KPCJulianEpochStandard() || self.epoch == KPCJulianEpochB1950(), @"Wrong epoch");
	KPCCoordinatesComponents components = [self componentsForSystem:KPCAstronomicalCoordinatesSystemEquatorial];
	return KPCGalacticLatitudeFromEquatorialComponents(&components, _epoch);
}

- (NSString *)galacticLongitudeString
{
	return [self galacticLongitudeStringWithUnits:[self units]];
}

- (NSString *)galacticLatitudeString
{
	return [self galacticLatitudeStringWithUnits:[self units]];
}

- (NSString *)galacticLongitudeStringWithUnits:(KPCCoordinatesUnits)units
{
	return [self valueString:self.galacticLongitude withUnits:units inHours:NO];
}

- (NSString *)galacticLatitudeStringWithUnits:(KPCCoordinatesUnits)units
{
	return [self valueString:self.galacticLatitude withUnits:units inHours:NO];
}








#pragma mark - Local Horizontal Accessors

- (double)altitudeForJulianDay:(double)jd observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
	return KPCSkyAltitudeForJulianDayRADecLongitudeLatitude(jd,
													  self.rightAscension,
													  self.declination,
													  obsCoords.longitude,
													  obsCoords.latitude);
}

- (double)azimuthForJulianDay:(double)jd observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
	return KPCSkyAzimuthForJulianDayRADecLongitudeLatitude(jd,
													 self.rightAscension,
													 self.declination,
													 obsCoords.longitude,
													 obsCoords.latitude);
}

- (NSString *)formattedHorizontalAzimuthWithUnits:(KPCCoordinatesUnits)theUnits forDate:(NSDate *)aDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
    double jd = julianDayForDate(aDate);
    double azimuthDegrees = [self azimuthForJulianDay:jd observatoryCoordinates:obsCoords];

	if (theUnits == KPCCoordinatesUnitsHoursAndDegrees) {
		return [@(azimuthDegrees) sexagesimalDegreeString];
	}
	else if (theUnits == KPCCoordinatesUnitsDegrees || theUnits == KPCCoordinatesUnitsRadians) {
		double newAzimuthDegrees = (theUnits == KPCCoordinatesUnitsDegrees) ? azimuthDegrees : azimuthDegrees * DEG2RAD;
		return [@(newAzimuthDegrees) decimalString:theUnits withDigits:6];
	}
	else {
		return @"";
	}
}

- (NSString *)formattedHorizontalAltitudeWithUnits:(KPCCoordinatesUnits)theUnits forDate:(NSDate *)aDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
    double jd = julianDayForDate(aDate);
    double altitudeDegrees = [self altitudeForJulianDay:jd observatoryCoordinates:obsCoords];

	if (theUnits == KPCCoordinatesUnitsHoursAndDegrees) {
		return [@(altitudeDegrees) sexagesimalDegreeString];
	}
	else if (theUnits == KPCCoordinatesUnitsDegrees || theUnits == KPCCoordinatesUnitsRadians) {
		double newAltitudeDegrees = (theUnits == KPCCoordinatesUnitsDegrees) ? altitudeDegrees : altitudeDegrees * DEG2RAD;
		return [@(newAltitudeDegrees) decimalString:theUnits withDigits:6];
	}
	else {
		return @"";
	}
}

- (NSArray *)horizontalAzimuthStringElementsForDate:(NSDate *)aDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
    double jd = julianDayForDate(aDate);
	double az = [self azimuthForJulianDay:jd observatoryCoordinates:obsCoords];
	return [@(az) sexagesimalComponentsStrings];
}

- (NSArray *)horizontalAltitudeStringElementsForDate:(NSDate *)aDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
    double jd = julianDayForDate(aDate);
	double alt = [self altitudeForJulianDay:jd observatoryCoordinates:obsCoords];
	return [@(alt) sexagesimalComponentsStrings];
}


#pragma mark - Coordinates modifiers

// INFERRED FROM SKYCALC "min_max_alt" function
- (double)maximumAltitudeForObservatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
	double sinAltitude = cos([self declination]*DEG2RAD)*cos([obsCoords latitude]*DEG2RAD) +
	sin([self declination]*DEG2RAD)*sin([obsCoords latitude]*DEG2RAD);
	return asin(sinAltitude) * RAD2DEG;
}

// INFERRED FROM SKYCALC "min_max_alt" function
- (double)minimumAltitudeForObservatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
	double sinAltitude = sin([self declination]*DEG2RAD)*sin([obsCoords latitude]*DEG2RAD) -
	cos([self declination]*DEG2RAD)*cos([obsCoords latitude]*DEG2RAD);
	return asin(sinAltitude) * RAD2DEG;
}

// INFERRED FROM SKYCALC "ha_alt" function.
// Returns hour angle at which object at dec is at altitude alt.
- (double)hourAngleAtAltitude:(double)anAltitude forObservatoryLatitude:(double)aLatitude
{
	double dec   = M_PI/2 - [self declination]*DEG2RAD;
	double lat   = M_PI/2 - aLatitude * DEG2RAD;
	double coalt = M_PI/2 - anAltitude * DEG2RAD;
	double cosHA = (cos(coalt) - cos(dec)*cos(lat)) / (sin(dec)*sin(lat));
	return acos(cosHA) * RAD2HOUR;
}

- (double)hourAngleForJulianDate:(double)aJulianDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
	double value = localSiderealTimeForJulianDayLongitude(aJulianDate, [obsCoords longitude]) - [self rightAscension];	
	if (value > 12.0) {
		value -= 24.0;
	}
	if (value < -12.0) {
		value += 24.0;
	}
	return value;
}

// See AA. p 115.
- (double)angularSeparationToCoordinates:(KPCAstronomicalCoordinates *)starCoords
{	
	return [self greatCircleAngularDistanceToCoordinates:starCoords];	
}

// See AA. p. 116
- (double)positionAngleToCoordinates:(KPCAstronomicalCoordinates *)starCoords
{
	double ra1  = [self rightAscension]*HOUR2RAD;
	double dec1 = [self declination]*DEG2RAD;
	double ra2  = [starCoords rightAscension]*HOUR2RAD;
	double dec2 = [starCoords declination]*DEG2RAD;

	double deltaAlpha = ra1 - ra2;
	
	double y = sin(deltaAlpha);
	double x = cos(dec2)*tan(dec1) - sin(dec2)*cos(deltaAlpha);
	
	double a = atan2(y, x) * RAD2DEG;
	
	if (a < 0) {
		a += 360.0;
	}
	
	return a;
}

// See AA, p. 98
- (double)paralacticAngleForJulianDate:(double)aJulianDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
	double hourAngle = [self hourAngleForJulianDate:aJulianDate observatoryCoordinates:obsCoords];
	double cosdec = cos([self declination]*DEG2RAD);
	double paralacticAngle = 0.0;
	
	if (cosdec != 0.0) {
		double cosha  = cos(hourAngle * HOUR2RAD);
		double sinha  = sin(hourAngle * HOUR2RAD);
		double tanlat = tan([obsCoords latitude] * DEG2RAD);
		double sindec = sin([self declination] * DEG2RAD);
		
		double y = sinha;
		double x = tanlat * cosdec - sindec * cosha;
		
		paralacticAngle = atan2(y, x);		
	} 
	else {
		paralacticAngle = ([obsCoords latitude] >= 0.0) ? M_PI : 0.0;
	}
	
	return paralacticAngle * RAD2DEG;
}


#pragma mark - Epoch Precession
//
// The algorithm has been reviewed using the rigorous method of AA, p. 134.
// We assume here that epochs are provided in the JULIAN calendar.
// Coordinates are transformed within the Equatorial system.
//
//- (STLAstronomicalCoordinates *)precessedCoordinatesFromEpoch:(double)startingEpoch toEpoch:(double)finalEpoch
- (KPCAstronomicalCoordinates *)precessedCoordinatesToEpoch:(double)finalEpoch
{
	if (self.epoch == finalEpoch) {
		return [self copy];
	}

	double startingEpoch = self.epoch;
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

	double RA = self.rightAscension*HOUR2RAD;
	double Dec = self.declination*DEG2RAD;

	double A = cos(Dec) * sin(RA + zeta);
	double B = cos(theta) * cos(Dec) * cos(RA + zeta) - sin(theta) * sin(Dec);
	double C = sin(theta) * cos(Dec) * cos(RA + zeta) + cos(theta) * sin(Dec);

	// atan2(y, x) = arc tangeant of y/x.
	double newRA  = atan2(A, B) + z;	// Result in radians.
	double newDec = asin(C);			// Result in radians.
	
	if (newRA < 0.0) { newRA += 2.0*M_PI; }

	return [[KPCAstronomicalCoordinates alloc] initWithRightAscension:newRA*RAD2HOUR declination:newDec*RAD2DEG epoch:finalEpoch];
}

- (KPCAstronomicalCoordinates *)precessedCoordinatesToDisplayedEpoch
{
	return [self precessedCoordinatesToEpoch:_displayedEpoch];
}

- (KPCAstronomicalCoordinates *)precessedCoordinatesToCurrentEpoch
{
	return [self precessedCoordinatesToEpoch:KPCJulianEpochCurrent()];
}

- (KPCAstronomicalCoordinates *)precessedCoordinatesToStandardEpoch
{
	return [self precessedCoordinatesToEpoch:STANDARD_JULIAN_EPOCH];
}

#pragma mark - Utils

- (NSString *)valueString:(double)value withUnits:(KPCCoordinatesUnits)units inHours:(BOOL)hours
{
	if (units == KPCCoordinatesUnitsHoursAndDegrees) {
		return (hours) ? [@(value) sexagesimalHourString] : [@(value) sexagesimalDegreeString];;
	}
	else if (units == KPCCoordinatesUnitsDegrees || units == KPCCoordinatesUnitsRadians) {
		double newValue = (units == KPCCoordinatesUnitsDegrees) ? value : value * DEG2RAD;
		return [@(newValue) decimalString:units withDigits:6];
	}
	else {
		return @"";
	}
}

@end
