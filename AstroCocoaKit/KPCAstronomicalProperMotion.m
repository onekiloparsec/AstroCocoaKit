//
//  STLAstronomicalProperMotion.m
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalProperMotion.h"
#import "KPCAstronomicalInfo+Private.h"

@implementation KPCAstronomicalProperMotion

- (void)setup
{
	[super setup];

	_declinationValue = NOT_A_SCIENTIFIC_NUMBER;
	_declinationErrorValue = NOT_A_SCIENTIFIC_NUMBER;
}

- (NSMutableArray *)mutableKeys
{
	NSMutableArray *keys = [super mutableKeys];
	[keys addObjectsFromArray:@[@"declinationValue", @"declinationErrorValue"]];
	return keys;
}


- (void)setSIMBADVOTableValue:(NSString *)v forKey:(NSString *)k
{
	if ([v length] == 0) {
		return;
	}
	
	if ([[k lowercaseString] isEqualToString:@"pmra"]) {
		self.rightAscensionValue = [v doubleValue];
	}
	else if ([[k lowercaseString] isEqualToString:@"pmdec"]) {
		self.declinationValue = [v doubleValue];
	}
	else if ([[k lowercaseString] isEqualToString:@"pmra_prec"]) {
		self.rightAscensionErrorValue = [v doubleValue];
	}
	else if ([[k lowercaseString] isEqualToString:@"pmdec_prec"]) {
		self.declinationErrorValue = [v doubleValue];
	}
	else if ([[k lowercaseString] isEqualToString:@"pm_bibcode"]) {
		self.bibcode = v;
	}
}

- (double)rightAscensionValue
{
	return self.value;
}

- (void)setRightAscensionValue:(double)rightAscensionValue
{
	self.value = rightAscensionValue;
}

- (double)rightAscensionErrorValue
{
	return self.errorValue;
}

- (void)setRightAscensionErrorValue:(double)rightAscensionErrorValue
{
	self.errorValue = rightAscensionErrorValue;
}

- (NSString *)valueName
{
	return @"Proper Motion";
}

- (NSString *)valueDescriptionPrefix
{
	return @"pm";
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	return @"mas/yr";
}

- (NSString *)valueDescriptionWithUnits:(NSUInteger)anotherUnit
{
	NSMutableString *s = [NSMutableString stringWithString:@""];
	if (self.rightAscensionValue != NOT_A_SCIENTIFIC_NUMBER && self.declinationValue != NOT_A_SCIENTIFIC_NUMBER) {
		[s appendFormat:@"%g", self.rightAscensionValue];
		if (self.rightAscensionErrorValue != NOT_A_SCIENTIFIC_NUMBER && self.rightAscensionErrorValue != 0.0) {
			[s appendFormat:@"±%g", self.rightAscensionErrorValue];
		}
		[s appendFormat:@", %g", self.declinationValue];
		if (self.declinationErrorValue != NOT_A_SCIENTIFIC_NUMBER && self.declinationErrorValue != 0.0) {
			[s appendFormat:@"±%g", self.declinationErrorValue];
		}
	}
	return [s copy];
}

- (NSString *)rightAscensionValueString
{
	if (self.rightAscensionValue == NOT_A_SCIENTIFIC_NUMBER || self.rightAscensionValue == 0.0) {
		return @"";
	}
	return [NSString stringWithFormat:@"%g mas/yr", self.rightAscensionValue];
}

- (NSString *)declinationValueString
{
	if (self.declinationValue == NOT_A_SCIENTIFIC_NUMBER || self.declinationValue == 0.0) {
		return @"";
	}
	return [NSString stringWithFormat:@"%g mas/yr", self.declinationValue];	
}

- (NSArray *)valueFullDescriptions
{
	return [super valueFullDescriptions];
}


@end






