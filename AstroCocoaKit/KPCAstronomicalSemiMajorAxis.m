//
//  STLAstronomicalSemiMajorAxis.m
//  iObserve
//
//  Created by Cédric Foellmi on 15/7/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalSemiMajorAxis.h"

@implementation KPCAstronomicalSemiMajorAxis

- (id)init
{
	self = [super init];
	if (self) {
		_parentStarRadius = NOT_A_SCIENTIFIC_NUMBER;
	}
	return self;
}

+ (KPCAstronomicalSemiMajorAxis *)semiMajorAxis:(double)v error:(double)e
{
	return [KPCAstronomicalSemiMajorAxis infoWithValue:v error:e units:KPCAstronomicalSemiMajorAxisUnitsUA];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		_parentStarRadius = [[aDecoder decodeObjectForKey:@"parentStarRadius"] doubleValue];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:@(self.parentStarRadius) forKey:@"parentStarRadius"];
}

- (NSString *)infoShortString
{
	return @"a";
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	switch (anotherUnit) {
		case KPCAstronomicalSemiMajorAxisUnitsUA:
		default:
			return @"AU";
			break;
		case KPCAstronomicalSemiMajorAxisUnitsRSun:
#ifdef DESKTOP
			return @"R⨀";
#else
			return @"R Sun";
#endif
			break;
		case KPCAstronomicalSemiMajorAxisUnitsRStar:
			return @"R Star";
			break;
	}
}

- (double)value:(double)v forUnits:(NSUInteger)anotherUnit
{
	if (self.unit == KPCAstronomicalSemiMajorAxisUnitsUA) {
		switch (anotherUnit) {
			case KPCAstronomicalSemiMajorAxisUnitsUA:
				return v;
				break;
			case KPCAstronomicalSemiMajorAxisUnitsRSun:
				return v * UA2KM / SOLAR_RADIUS_KM;
				break;
			case KPCAstronomicalSemiMajorAxisUnitsRStar:
				return v * UA2KM / (self.parentStarRadius * SOLAR_RADIUS_KM);
				break;
		}
	}
	else if (self.unit == KPCAstronomicalSemiMajorAxisUnitsRSun) {
		switch (anotherUnit) {
			case KPCAstronomicalSemiMajorAxisUnitsUA:
				return v * SOLAR_RADIUS_KM / UA2KM;
				break;
			case KPCAstronomicalSemiMajorAxisUnitsRSun:
				return v;
				break;
			case KPCAstronomicalSemiMajorAxisUnitsRStar:
				return v * SOLAR_RADIUS_KM / (self.parentStarRadius * SOLAR_RADIUS_KM);
				break;
		}
	}
	else if (self.unit == KPCAstronomicalSemiMajorAxisUnitsRStar) {
		switch (anotherUnit) {
			case KPCAstronomicalSemiMajorAxisUnitsUA:
				return v * (self.parentStarRadius * SOLAR_RADIUS_KM) / UA2KM;
				break;
			case KPCAstronomicalSemiMajorAxisUnitsRSun:
				return v * (self.parentStarRadius * SOLAR_RADIUS_KM) / SOLAR_RADIUS_KM;
				break;
			case KPCAstronomicalSemiMajorAxisUnitsRStar:
				return v;
				break;
		}		
	}
	return NOT_A_SCIENTIFIC_NUMBER;
}


- (NSString *)valueName
{
	return @"Semi Major Axis";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return (self.parentStarRadius == NOT_A_SCIENTIFIC_NUMBER) ? 2 : 3;
}

- (NSString *)valueDescriptionPrefix
{
	return @"a";
}

@end

