//
//  STLSkyPosition.m
//  iObserve
//
//  Created by Cédric Foellmi on 1/10/11.
//  Copyright 2011 Soft Tenebras Lux. All rights reserved.
//

#import "KPCSkyCoordinates.h"

#import "KPCAstronomicalCoordinates.h"
#import "KPCTerrestrialCoordinates.h"

#import "KPCTimes.h"

@implementation KPCSkyCoordinates

- (id)initWithAzimuth:(double)az altitude:(double)alt
{
	self = [super initWithTheta:az phi:alt units:KPCCoordinatesUnitsDegrees];
	return self;
}

+ (KPCSkyCoordinates *)coordinatesWithAzimuth:(double)az altitude:(double)alt
{
    return [[KPCSkyCoordinates alloc] initWithAzimuth:az altitude:alt];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"az %.6f alt %.6f", self.azimuth, self.altitude];
}

- (double)azimuth
{
	return self.theta;
}

- (double)altitude
{
	return self.phi;
}

// See P94. in AA.
- (KPCAstronomicalCoordinates *)astroCoordinatesForJulianDay:(double)jd obsCoordinates:(KPCTerrestrialCoordinates *)obsCoords
{
	NSAssert(obsCoords, @"Missing observatory coordinates coordinates");
	NSAssert([obsCoords isKindOfClass:[KPCTerrestrialCoordinates class]], @"Wrong coordinates class.");

	double sinA = sin(self.azimuth*DEG2RAD);
	double cosA = cos(self.azimuth*DEG2RAD);
	double tanh = tan(self.altitude*DEG2RAD);
	double cosh = cos(self.altitude*DEG2RAD);
	double sinh = sin(self.altitude*DEG2RAD);

	double sinlat = sin([obsCoords latitude]*DEG2RAD);
	double coslat = cos([obsCoords latitude]*DEG2RAD);
	
	double sindelta = sinlat*sinh - coslat*cosh*cosA;
	double delta = asin(sindelta)*RAD2DEG;
	
	double HA = atan2(sinA, cosA*sinlat + tanh*coslat)*RAD2HOUR;
	
	double lmst = localSiderealTimeForJulianDayLongitude(jd, [obsCoords longitude]);
	double alpha = lmst - HA;

	alpha = fmod(alpha + DAY2HOUR, DAY2HOUR);
	
	KPCAstronomicalCoordinates *coords = [KPCAstronomicalCoordinates coordinatesWithRightAscension:alpha declination:delta];
	return coords;
}

- (double)minimalAzimuthDifference:(KPCSkyCoordinates *)other
{
	NSAssert(other, @"Missing other coordinates");
	NSAssert([other isKindOfClass:[KPCSkyCoordinates class]], @"Wrong coordinates class.");

	double scaledDiff = fabs(self.azimuth - other.azimuth)/360.0;
	return MIN(scaledDiff, 1.0-scaledDiff) * 360.0;
}

- (double)minimalAzimuthDifferenceSign:(KPCSkyCoordinates *)other
{
	NSAssert(other, @"Missing other coordinates");
	NSAssert([other isKindOfClass:[KPCSkyCoordinates class]], @"Wrong coordinates class.");

	double minDiff = [self minimalAzimuthDifference:other];
	return (self.azimuth < other.azimuth && self.azimuth + minDiff == other.azimuth) ? 1.0 : -1.0;
}

@end

