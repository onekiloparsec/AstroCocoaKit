//
//  STLAstronomicalFlux.m
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalFlux.h"
#import "KPCAstronomicalInfo+Private.h"

@implementation KPCAstronomicalFlux

- (void)setup
{
	[super setup];
	_name = UNDEFINED_STRING_PROPERTY;
}

- (NSMutableArray *)mutableKeys
{
	NSMutableArray *keys = [super mutableKeys];
	[keys addObject:@"name"];
	return keys;
}

- (void)setSIMBADVOTableValue:(NSString *)v forKey:(NSString *)k
{
	if ([v length] == 0) {
		return;
	}
	
	if ([k hasPrefix:@"FILTER_NAME_"]) {
		self.name = v;
	}
	else if ([k hasPrefix:@"FLUX_ERROR_"]) {
		self.errorValue = [v doubleValue];
	}
	else if ([k hasPrefix:@"FLUX_UNIT_"]) {
		self.stringUnit = v;
	}
	else if ([k hasPrefix:@"FLUX_BIBCODE_"]) {
		self.bibcode = v;
	}
	else if ([k hasPrefix:@"FLUX_"]) { // Must be the last!
		self.value = [v doubleValue];
	}
}

- (NSString *)valueName
{
	return @"Magnitude";
}

- (NSString *)valueDescriptionPrefix
{
	return [@"mag " stringByAppendingString:(_name) ? _name : @""];
}

@end





