//
//  STLAstronomicalFlux.m
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalFlux.h"
#import "KPCAstronomicalInfo+Private.h"

@interface KPCAstronomicalFlux ()
@property(nonatomic, copy) NSString *name;
@end

@implementation KPCAstronomicalFlux

+ (KPCAstronomicalFlux *)fluxWithValue:(double)v name:(NSString *)n bibcode:(NSString *)bibcode
{
	KPCAstronomicalFlux *f = [KPCAstronomicalFlux emptyInfo];
	f.value = v;
	f.name = n;
	f.bibcode = bibcode;
	return f;
}

+ (KPCAstronomicalFlux *)fluxWithValue:(double)v error:(double)e name:(NSString *)n
{
	KPCAstronomicalFlux *f = [KPCAstronomicalFlux emptyInfo];
	f.value = v;
	f.errorValue = e;
	f.name = n;
	return f;
}

- (void)setup
{
	[super setup];
	_name = UNDEFINED_STRING_VALUE;
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





