//
//  STLAstronomicalEffectiveTemperature.m
//  iObserve
//
//  Created by onekiloparsec on 5/11/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalEffectiveTemperature.h"

@implementation KPCAstronomicalEffectiveTemperature

+ (KPCAstronomicalEffectiveTemperature *)temperature:(double)v error:(double)e
{
	return [KPCAstronomicalEffectiveTemperature infoWithValue:v error:e units:KPCAstronomicalEffectiveTemperatureUnitKelvin];
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	switch (anotherUnit) {
		case KPCAstronomicalEffectiveTemperatureUnitKelvin:
		default:
			return @"K";
			break;
		case KPCAstronomicalEffectiveTemperatureUnitCelsius:
			return @"ºC";
			break;
	}
}

- (double)value:(double)v forUnits:(NSUInteger)anotherUnit
{
	if (self.unit == KPCAstronomicalEffectiveTemperatureUnitKelvin) {
		switch (anotherUnit) {
			case KPCAstronomicalEffectiveTemperatureUnitKelvin:
				return v;
				break;
			case KPCAstronomicalEffectiveTemperatureUnitCelsius:
				return v + ABSOLUTE_ZERO_TEMPERATURE_CELSIUS;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalEffectiveTemperatureUnitCelsius) {
		switch (anotherUnit) {
			case KPCAstronomicalEffectiveTemperatureUnitKelvin:
				return v - ABSOLUTE_ZERO_TEMPERATURE_CELSIUS;
				break;
			case KPCAstronomicalEffectiveTemperatureUnitCelsius:
				return v;
				break;
		}
	}
	return NOT_A_SCIENTIFIC_NUMBER;
}

- (NSString *)valueName
{
	return @"Effective Temperature";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 2;
}

- (NSString *)valueDescriptionPrefix
{
	return @"Teff";
}

@end
