//
//  STLAstronomicalDistance.m
//  iObserve
//
//  Created by Cédric Foellmi on 24/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalDistance.h"

@implementation KPCAstronomicalDistance

+ (KPCAstronomicalDistance *)distance:(double)v error:(double)e unit:(KPCAstronomicalDistanceUnit)u;
{
	return [KPCAstronomicalDistance infoWithValue:v error:e units:u];
}

- (NSString *)unitStringForUnits:(NSUInteger)unit
{
	switch (unit) {
		case KPCAstronomicalDistanceUnitUA:
			return @"UA";
			break;
		case KPCAstronomicalDistanceUnitLightYear:
			return @"ly";
			break;
		case KPCAstronomicalDistanceUnitParsec:
			return @"pc";
			break;
		default:
			return @"";
			break;
	}
}

- (double)value:(double)v forUnits:(NSUInteger)anotherUnit
{
	if (self.unit == KPCAstronomicalDistanceUnitUA) {
		switch (anotherUnit) {
			case KPCAstronomicalDistanceUnitUA:
			default:
				return v;
				break;
			case KPCAstronomicalDistanceUnitLightYear:
				return v / PC2UA * PC2LY;
				break;
			case KPCAstronomicalDistanceUnitParsec:
				return v / PC2UA;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalDistanceUnitLightYear) {
		switch (anotherUnit) {
			case KPCAstronomicalDistanceUnitUA:
				return v / PC2LY * PC2UA;
				break;
			case KPCAstronomicalDistanceUnitLightYear:
			default:
				return v;
				break;
			case KPCAstronomicalDistanceUnitParsec:
				return v / PC2LY;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalDistanceUnitParsec) {
		switch (anotherUnit) {
			case KPCAstronomicalDistanceUnitUA:
				return v * PC2UA;
				break;
			case KPCAstronomicalDistanceUnitLightYear:
				return v * PC2LY;
				break;
			case KPCAstronomicalDistanceUnitParsec:
			default:
				return v;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalDistanceUnitKiloParsec) {
		switch (anotherUnit) {
			case KPCAstronomicalDistanceUnitUA:
				return v * 1000 * PC2UA;
				break;
			case KPCAstronomicalDistanceUnitLightYear:
				return v * 1000 * PC2LY;
				break;
			case KPCAstronomicalDistanceUnitParsec:
				return v * 1000;
				break;
			default:
				return v;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalDistanceUnitMegaParsec) {
		switch (anotherUnit) {
			case KPCAstronomicalDistanceUnitUA:
				return v * 1e6 * PC2UA;
				break;
			case KPCAstronomicalDistanceUnitLightYear:
				return v * 1e6 * PC2LY;
				break;
			case KPCAstronomicalDistanceUnitParsec:
				return v * 1e6;
				break;
			default:
				return v;
				break;
		}
	}
	else {
		return NOT_A_SCIENTIFIC_NUMBER;
	}
}

#pragma mark - STLAstronomicalInfoValueDescription

- (NSString *)valueName
{
	return @"Distance";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 3;
}

- (NSString *)valueDescriptionPrefix
{
	return @"d";
}

@end

