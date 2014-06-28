//
//  STLAstronomicalRadius.m
//  iObserve
//
//  Created by Cédric Foellmi on 10/25/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalRadius.h"

@implementation KPCAstronomicalRadius

+ (KPCAstronomicalRadius *)radius:(double)v
{
	return [KPCAstronomicalRadius infoWithValue:v units:KPCAstronomicalRadiusUnitSun];
}

+ (KPCAstronomicalRadius *)jupiterRadius:(double)v error:(double)e;
{
	return [KPCAstronomicalRadius infoWithValue:v error:e units:KPCAstronomicalRadiusUnitJupiter];
}

+ (KPCAstronomicalRadius *)solarRadius:(double)v error:(double)e;
{
	return [KPCAstronomicalRadius infoWithValue:v error:e units:KPCAstronomicalRadiusUnitSun];
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	switch ((KPCAstronomicalRadiusUnit)anotherUnit) {
		case KPCAstronomicalRadiusUnitSun:
		default:
#ifdef DESKTOP
			return @"R⨀";
#else
			return @"R Sun";
#endif
			break;
		case KPCAstronomicalRadiusUnitJupiter:
			return @"R Jupiter";
			break;
		case KPCAstronomicalRadiusUnitNeptune:
			return @"R Neptune";
			break;
		case KPCAstronomicalRadiusUnitEarth:
#ifdef DESKTOP
			return @"R⨁";
#else
			return @"R Earth";
#endif
			break;
	}
	return @"";
}

- (double)value:(double)v forUnits:(NSUInteger)anotherUnit
{
	if (self.unit == KPCAstronomicalRadiusUnitSun) {
		switch (anotherUnit) {
			case KPCAstronomicalRadiusUnitSun:
			default:
				return v;
				break;
			case KPCAstronomicalRadiusUnitJupiter:
				return v * SOLAR_RADIUS_KM / JUPITER_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitNeptune:
				return v * SOLAR_RADIUS_KM / NEPTUNE_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitEarth:
				return v * SOLAR_RADIUS_KM / EARTH_RADIUS_KM;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalRadiusUnitJupiter) {
		switch (anotherUnit) {
			case KPCAstronomicalRadiusUnitSun:
				return v * JUPITER_RADIUS_KM / SOLAR_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitJupiter:
			default:
				return v;
				break;
			case KPCAstronomicalRadiusUnitNeptune:
				return v * JUPITER_RADIUS_KM / NEPTUNE_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitEarth:
				return v * JUPITER_RADIUS_KM / EARTH_RADIUS_KM;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalRadiusUnitNeptune) {
		switch (anotherUnit) {
			case KPCAstronomicalRadiusUnitSun:
				return v * NEPTUNE_RADIUS_KM / SOLAR_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitJupiter:
				return v * NEPTUNE_RADIUS_KM / JUPITER_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitNeptune:
			default:
				return v;
				break;
			case KPCAstronomicalRadiusUnitEarth:
				return v * NEPTUNE_RADIUS_KM / EARTH_RADIUS_KM;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalRadiusUnitEarth) {
		switch (anotherUnit) {
			case KPCAstronomicalRadiusUnitSun:
				return v * EARTH_RADIUS_KM / SOLAR_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitJupiter:
				return v * EARTH_RADIUS_KM / JUPITER_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitNeptune:
				return v * EARTH_RADIUS_KM / NEPTUNE_RADIUS_KM;
				break;
			case KPCAstronomicalRadiusUnitEarth:
			default:
				return v;
				break;
		}
	}
	return NOT_A_SCIENTIFIC_NUMBER;
}

- (NSString *)valueName
{
	return @"Radius";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 4;
}

- (NSString *)valueDescriptionPrefix
{
	return @"R";
}

@end
