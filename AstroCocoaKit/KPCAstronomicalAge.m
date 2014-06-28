//
//  STLAstronomicalAge.m
//  iObserve
//
//  Created by onekiloparsec on 5/11/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalAge.h"

@implementation KPCAstronomicalAge

+ (KPCAstronomicalAge *)age:(double)v error:(double)e
{
	return [KPCAstronomicalAge infoWithValue:v error:e units:KPCAstronomicalAgeUnitGyr];
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	switch (anotherUnit) {
		case KPCAstronomicalAgeUnitGyr:
		default:
			return @"Gyr";
			break;
		case STLAstronomicalAgeUnitMyr:
			return @"Myr";
			break;
		case STLAstronomicalAgeUnitYr:
			return @"yr";
			break;
	}
}

- (double)value:(double)v forUnits:(STLAstronomicalAgeUnit)anotherUnit
{
	if (self.unit == KPCAstronomicalAgeUnitGyr) {
		switch (anotherUnit) {
			case KPCAstronomicalAgeUnitGyr:
				return v;
				break;
			case STLAstronomicalAgeUnitMyr:
				return v * 1e3;
				break;
			case STLAstronomicalAgeUnitYr:
				return v * 1e9;
				break;
		}
	}
	else if (self.unit == STLAstronomicalAgeUnitMyr) {
		switch (anotherUnit) {
			case KPCAstronomicalAgeUnitGyr:
				return v / 1e3;
				break;
			case STLAstronomicalAgeUnitMyr:
				return v;
				break;
			case STLAstronomicalAgeUnitYr:
				return v * 1e6;
				break;
		}
	}
	else if (self.unit == STLAstronomicalAgeUnitYr) {
		switch (anotherUnit) {
			case KPCAstronomicalAgeUnitGyr:
				return v / 1e9;
				break;
			case STLAstronomicalAgeUnitMyr:
				return v / 1e6;
				break;
			case STLAstronomicalAgeUnitYr:
				return v;
				break;
		}
	}
	return NOT_A_SCIENTIFIC_NUMBER;
}

- (NSString *)valueName
{
	return @"Age";
}

- (NSString *)valueDescriptionPrefix
{
	return @"age";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 3;
}

@end
