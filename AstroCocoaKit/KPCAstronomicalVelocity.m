//
//  STLAstronomicalVelocity.m
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalVelocity.h"
#import "KPCAstronomicalInfo+Private.h"

double redshiftForVelocity(double kms) {
	double gamma = sqrt(1. - pow(kms/SPEED_OF_LIGHT_KMS, 2.0));
	return (1. + kms/SPEED_OF_LIGHT_KMS) * gamma - 1;
}

double velocityForRedshift(double z) {
	return (pow(1+z, 2.0) - 1)/(pow(1+z, 2.0) + 1) * SPEED_OF_LIGHT_KMS;
}

@implementation KPCAstronomicalVelocity

+ (KPCAstronomicalVelocity *)emptyRadialVelocity
{
	KPCAstronomicalVelocity *v = [[KPCAstronomicalVelocity alloc] init];
	v.unit = KPCAstronomicalVelocityTypeRadialVelocity;
	return v;
}

+ (KPCAstronomicalVelocity *)emptyRedshift
{
	KPCAstronomicalVelocity *v = [[KPCAstronomicalVelocity alloc] init];
	v.unit = KPCAstronomicalVelocityTypeRedshift;
	return v;	
}

- (void)setSIMBADVOTableValue:(NSString *)v forKey:(NSString *)k
{
	if ([v length] == 0) {
		return;
	}

	if ([k isEqualToString:@"RVZ_TYPE"]) {
		self.unit = ([v isEqualToString:@"v"]) ? KPCAstronomicalVelocityTypeRadialVelocity : KPCAstronomicalVelocityTypeRedshift;
	}
	else if ([k isEqualToString:@"RV_VALUE"]) {
		self.value = [v doubleValue];
		self.unit = KPCAstronomicalVelocityTypeRadialVelocity;
	}
	else if ([k isEqualToString:@"Z_VALUE"]) {
		self.value = [v doubleValue];
		self.unit = KPCAstronomicalVelocityTypeRedshift;
	}
	else if ([k isEqualToString:@"RVZ_RADVEL"]) {
		self.value = [v doubleValue];
	}
	else if ([k isEqualToString:@"RVZ_ERROR"]) {
		self.errorValue = [v doubleValue];
	}
	else if ([k isEqualToString:@"RVZ_WAVELENGTH"]) {
		self.wavelength = v;
	}
	else if ([k isEqualToString:@"RVZ_BIBCODE"]) {
		self.bibcode = v;
	}
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	switch (anotherUnit) {
		case KPCAstronomicalVelocityTypeRadialVelocity:
			return @"km/s";
			break;
		default:
			return @"";
			break;
	}
}

- (double)value:(double)v forUnits:(NSUInteger)anotherUnit
{
	if (self.unit == KPCAstronomicalVelocityTypeRadialVelocity) {
		switch (anotherUnit) {
			case KPCAstronomicalVelocityTypeRadialVelocity:
				return v;
				break;
			case KPCAstronomicalVelocityTypeRedshift:
				return redshiftForVelocity(v);
				break;
			default:
				return NOT_A_SCIENTIFIC_NUMBER;
				break;
		}
	}
	else if (self.unit == KPCAstronomicalVelocityTypeRedshift) {
		switch (anotherUnit) {
			case KPCAstronomicalVelocityTypeRadialVelocity:
				return velocityForRedshift(v);
				break;
			case KPCAstronomicalVelocityTypeRedshift:
				return v;
				break;
			default:
				return NOT_A_SCIENTIFIC_NUMBER;
				break;
		}
	}
	else {
		return NOT_A_SCIENTIFIC_NUMBER;
	}
}

- (NSString *)valueName
{
	return @"Radial Velocity & Redshift";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 2;
}

- (NSString *)valueDescriptionPrefix
{
	return (self.unit == KPCAstronomicalVelocityTypeRadialVelocity) ? @"RV" : @"z";
}

@end
