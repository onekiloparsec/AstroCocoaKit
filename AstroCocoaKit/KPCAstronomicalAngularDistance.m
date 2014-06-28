//
//  STLAstronomicalAngularDistance.m
//  iObserve
//
//  Created by Cédric Foellmi on 15/7/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalAngularDistance.h"

@implementation KPCAstronomicalAngularDistance

+ (KPCAstronomicalAngularDistance *)angularDistance:(double)v error:(double)e
{
	return [KPCAstronomicalAngularDistance infoWithValue:v error:e units:KPCAstronomicalAngularDistanceUnitArcsecond];
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	switch (anotherUnit) {
		case KPCAstronomicalAngularDistanceUnitArcsecond:
			return @"\"";
			break;
		case KPCAstronomicalAngularDistanceUnitArcminute:
		default:
			return @"'";
			break;
	}
}

- (double)value:(double)v forUnits:(KPCAstronomicalAngularDistanceUnit)anotherUnit
{
	if (self.unit == KPCAstronomicalAngularDistanceUnitArcsecond) {
		switch (anotherUnit) {
			case KPCAstronomicalAngularDistanceUnitArcsecond:
				return v;
				break;
			case KPCAstronomicalAngularDistanceUnitArcminute:
				return v / 60.0;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalAngularDistanceUnitArcminute) {
		switch (anotherUnit) {
			case KPCAstronomicalAngularDistanceUnitArcsecond:
				return v * 60.0;
				break;
			case KPCAstronomicalAngularDistanceUnitArcminute:
				return v;
				break;
		}
	}
	return NOT_A_SCIENTIFIC_NUMBER;
}

- (NSString *)valueName
{
	return @"Angular Distance";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 2;
}

- (NSString *)valueDescriptionPrefix
{
	return @"ang. dist.";
}

@end

