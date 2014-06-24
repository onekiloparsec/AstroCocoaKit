//
//  Coordinates.m
//  iObserve
//
//  Created by Soft Tenebras Lux on 16/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//
// ------------------------------------------------------------------------------------------------------------
// BE: The base object for all coordinates.
// DO: Trigonometric computations of spherical coordinates.
// ------------------------------------------------------------------------------------------------------------
//

#import "KPCSphericalCoordinates.h"
#import "KPCScientificConstants.h"

// Haversine function. See p115 in AA.
static inline double hav(double theta)
{
	//	return (1.0 - cos(theta))/2.0;
	return sin(theta/2.0)*sin(theta/2.0);
}

// Inverse haversine function.
static inline double ahav(double x)
{
	//	return acos(1.0-2.0*x);
	return 2.0 * asin(sqrt(x));
}

@implementation KPCSphericalCoordinates

- (id)init
{
	self = [super init];
	if (self) {
		_theta = NOT_A_SCIENTIFIC_NUMBER;
		_phi   = NOT_A_SCIENTIFIC_NUMBER;
		_units = KPCCoordinatesUnitsRadians;
		_displayedUnits = _units;
	}
	return self;
}

- (id)initWithTheta:(double)t phi:(double)p units:(KPCCoordinatesUnits)u
{
	self = [super init];
	if (self) {
		_theta = t;
		_phi   = p;
		_units = u;
		_displayedUnits = _units;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super init];
	if (self) {
		if ([coder containsValueForKey:@"theta"]) {
			_theta = [[coder decodeObjectForKey:@"theta"] doubleValue];
		}
		else {
			_theta = [[coder decodeObjectForKey:@"azimuth"] doubleValue];
		}
		if ([coder containsValueForKey:@"phi"]) {
			_phi = [[coder decodeObjectForKey:@"phi"] doubleValue];
		}
		else {
			_phi = [[coder decodeObjectForKey:@"elevation"] doubleValue];
		}

		_units = [[coder decodeObjectForKey:@"units"] intValue];

		if ([coder containsValueForKey:@"displayedUnits"]) {
			_displayedUnits = [[coder decodeObjectForKey:@"displayedUnits"] unsignedIntegerValue];
		}
		else {
			_displayedUnits = _units;
		}

		NSAssert(!isnan(_theta), @"Theta is nan!");
		NSAssert(!isnan(_phi), @"Phi is nan!");
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeObject:@(_theta) forKey:@"theta"];
	[coder encodeObject:@(_phi) forKey:@"phi"];
	[coder encodeObject:@(_units) forKey:@"units"];
	[coder encodeObject:@(_displayedUnits) forKey:@"displayedUnits"];
}

- (id)copyWithZone:(NSZone *)zone
{
	KPCSphericalCoordinates *newCoords = [[KPCSphericalCoordinates allocWithZone:zone] initWithTheta:_theta phi:_phi units:_units];
	newCoords.displayedUnits = self.displayedUnits;
	return newCoords;
}

+ (instancetype)emptyCoordinates
{
    return [[[self class] alloc] init];
}

- (BOOL)areEmpty
{
    return (self.theta == NOT_A_SCIENTIFIC_NUMBER) && (self.phi == NOT_A_SCIENTIFIC_NUMBER);
}

- (KPCCoordinatesComponents)components
{
	KPCCoordinatesComponents components;
	components.theta = _theta;
	components.phi = _phi;
	components.units = _units;
	return components;
}

- (double)theta
{
	return _theta;
}

- (double)phi
{
	return _phi;
}

- (KPCCoordinatesUnits)units
{
	return _units;
}

// See http://wiki.astrogrid.org/bin/view/Astrogrid/CelestialCoordinates
- (double)greatCircleAngularDistanceToCoordinates:(KPCSphericalCoordinates *)otherCoordinates
{
	double scale = 1.0;
	switch (_units) {
		case KPCCoordinatesUnitsDegrees:
			scale = DEG2RAD;
			break;
		case KPCCoordinatesUnitsHours:
			scale = HOUR2RAD;
			break;
		default:
			break;
	}

	double otherScale = 1.0;
	switch (otherCoordinates.units) {
		case KPCCoordinatesUnitsDegrees:
			otherScale = DEG2RAD;
			break;
		case KPCCoordinatesUnitsHours:
			otherScale = HOUR2RAD;
			break;
		default:
			break;
	}

	double dec1 = _phi * scale;
	double dec2 = otherCoordinates.phi * otherScale;
	double ra1  = _theta * scale;
	double ra2  = otherCoordinates.theta * otherScale;

	double t1 = hav(dec1-dec2);
	double t2 = cos(dec1)*cos(dec2)*hav(ra1-ra2);
	double result = ahav(t1 + t2); // radians

	return result * RAD2DEG;
}

+ (NSString *)shortPositionAngleString:(double)value
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

+ (NSString *)positionAngleString:(double)value
{
	return [NSString stringWithFormat:@"PA %.0fº - %@",
			value, [KPCSphericalCoordinates shortPositionAngleString:value]];
}

+ (NSString *)separationAngleString:(double)value
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

@end
