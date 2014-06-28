//
//  STLAstronomicalMass.m
//  iObserve
//
//  Created by Cédric Foellmi on 24/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalMass.h"

@implementation KPCAstronomicalMass

+ (KPCAstronomicalMass *)solarMass:(double)v
{
	return [KPCAstronomicalMass infoWithValue:v units:KPCAstronomicalMassUnitSun];
}

+ (KPCAstronomicalMass *)solarMass:(double)v error:(double)e
{
	return [KPCAstronomicalMass infoWithValue:v error:e units:KPCAstronomicalMassUnitSun];
}

+ (KPCAstronomicalMass *)jupiterMass:(double)v
{
	return [KPCAstronomicalMass infoWithValue:v units:KPCAstronomicalMassUnitJupiter];
}

+ (KPCAstronomicalMass *)jupiterMass:(double)v error:(double)e
{
	return [KPCAstronomicalMass infoWithValue:v error:e units:KPCAstronomicalMassUnitJupiter];
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	switch ((KPCAstronomicalMassUnit)anotherUnit) {
		case KPCAstronomicalMassUnitSun:
		default:
#ifdef DESKTOP
			return @"M⨀";
#else
			return @"M Sun";
#endif
			break;
		case KPCAstronomicalMassUnitJupiter:
			return @"M Jupiter";
			break;
		case KPCAstronomicalMassUnitNeptune:
			return @"M Neptune";
			break;
		case KPCAstronomicalMassUnitEarth:
#ifdef DESKTOP
			return @"M⨁";
#else
			return @"M Earth";
#endif
			break;
	}
	return @"";
}

- (double)value:(double)v forUnits:(NSUInteger)anotherUnit
{
	if (self.unit == KPCAstronomicalMassUnitSun) {
		switch (anotherUnit) {
			case KPCAstronomicalMassUnitSun:
				return v;
				break;
			case KPCAstronomicalMassUnitJupiter:
				return v * SOLAR_MASS / JUPITER_MASS;
				break;
			case KPCAstronomicalMassUnitNeptune:
				return v * SOLAR_MASS / NEPTUNE_MASS;
				break;
			case KPCAstronomicalMassUnitEarth:
				return v * SOLAR_MASS / EARTH_MASS;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalMassUnitJupiter) {
		switch (anotherUnit) {
			case KPCAstronomicalMassUnitSun:
				return v * JUPITER_MASS / SOLAR_MASS;
				break;
			case KPCAstronomicalMassUnitJupiter:
				return v;
				break;
			case KPCAstronomicalMassUnitNeptune:
				return v * JUPITER_MASS / NEPTUNE_MASS;
				break;
			case KPCAstronomicalMassUnitEarth:
				return v * JUPITER_MASS / EARTH_MASS;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalMassUnitNeptune) {
		switch (anotherUnit) {
			case KPCAstronomicalMassUnitSun:
				return v * NEPTUNE_MASS / SOLAR_MASS;
				break;
			case KPCAstronomicalMassUnitJupiter:
				return v * NEPTUNE_MASS / JUPITER_MASS;
				break;
			case KPCAstronomicalMassUnitNeptune:
				return v;
				break;
			case KPCAstronomicalMassUnitEarth:
				return v * NEPTUNE_MASS / EARTH_MASS;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalMassUnitEarth) {
		switch (anotherUnit) {
			case KPCAstronomicalMassUnitSun:
				return v * EARTH_MASS / SOLAR_MASS;
				break;
			case KPCAstronomicalMassUnitJupiter:
				return v * EARTH_MASS / JUPITER_MASS;
				break;
			case KPCAstronomicalMassUnitNeptune:
				return v * EARTH_MASS / NEPTUNE_MASS;
				break;
			case KPCAstronomicalMassUnitEarth:
				return v;
				break;
		}
	}
	return NOT_A_SCIENTIFIC_NUMBER;
}

- (NSString *)valueName
{
	return @"Mass";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 4;
}

- (NSString *)valueDescriptionPrefix
{
	return @"M";
}

@end
