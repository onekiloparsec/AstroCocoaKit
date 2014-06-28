//
//  STLAstronomicalOrbitalPeriod.m
//  iObserve
//
//  Created by Cédric Foellmi on 15/7/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalOrbitalPeriod.h"

@implementation KPCAstronomicalOrbitalPeriod

+ (KPCAstronomicalOrbitalPeriod *)orbitalPeriod:(double)v error:(double)e
{
	return [KPCAstronomicalOrbitalPeriod infoWithValue:v error:e units:KPCAstronomicalOrbitalPeriodUnitDays];
}

- (NSString *)infoShortString
{
	return @"P";
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
    NSString *s = @"";
    switch (anotherUnit) {
        case KPCAstronomicalOrbitalPeriodUnitHours:
            return @"hours";
            break;
        case KPCAstronomicalOrbitalPeriodUnitDays:
        default:
            return @"days";
            break;
        case KPCAstronomicalOrbitalPeriodUnitWeeks:
            return @"weeks";
            break;
        case KPCAstronomicalOrbitalPeriodUnitYears:
            return @"years";
            break;
    }
    return s;
}

- (double)value:(double)v forUnits:(NSUInteger)anotherUnit
{
	if (self.unit == KPCAstronomicalOrbitalPeriodUnitYears) {
		switch (anotherUnit) {
			case KPCAstronomicalOrbitalPeriodUnitYears:
				return v;
				break;
			case KPCAstronomicalOrbitalPeriodUnitWeeks:
				return v * 52.0;
				break;
			case KPCAstronomicalOrbitalPeriodUnitDays:
				return v * AVERAGE_GREGORIAN_YEAR;
				break;
			case KPCAstronomicalOrbitalPeriodUnitHours:
				return v * AVERAGE_GREGORIAN_YEAR * 24.0;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalOrbitalPeriodUnitWeeks) {
		switch (anotherUnit) {
			case KPCAstronomicalOrbitalPeriodUnitYears:
				return v / 52.0;
				break;
			case KPCAstronomicalOrbitalPeriodUnitWeeks:
				return v;
				break;
			case KPCAstronomicalOrbitalPeriodUnitDays:
				return v * 7.0;
				break;
			case KPCAstronomicalOrbitalPeriodUnitHours:
				return v * 7.0 * 24.0;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalOrbitalPeriodUnitDays) {
		switch (anotherUnit) {
			case KPCAstronomicalOrbitalPeriodUnitYears:
				return v / AVERAGE_GREGORIAN_YEAR;
				break;
			case KPCAstronomicalOrbitalPeriodUnitWeeks:
				return v / 7.0;
				break;
			case KPCAstronomicalOrbitalPeriodUnitDays:
				return v;
				break;
			case KPCAstronomicalOrbitalPeriodUnitHours:
				return v * 24.0;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalOrbitalPeriodUnitHours) {
		switch (anotherUnit) {
			case KPCAstronomicalOrbitalPeriodUnitYears:
				return v / 24.0 / AVERAGE_GREGORIAN_YEAR;
				break;
			case KPCAstronomicalOrbitalPeriodUnitWeeks:
				return v / 24.0 / 7.0;
				break;
			case KPCAstronomicalOrbitalPeriodUnitDays:
				return v / 24.0;
				break;
			case KPCAstronomicalOrbitalPeriodUnitHours:
				return v;
				break;
		}	
	}
	return NOT_A_SCIENTIFIC_NUMBER;
}

- (NSString *)valueName
{
	return @"Orbital Period";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 4;
}

- (NSString *)valueDescriptionPrefix
{
	return @"P";
}

@end

