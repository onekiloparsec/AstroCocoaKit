//
//  STLAstronomicalColor.m
//  iObserve
//
//  Created by Cédric Foellmi on 1/5/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalColor.h"
#import "KPCAstronomicalInfo+Private.h"

@implementation KPCAstronomicalColor

- (void)setup
{
	[super setup];
	_firstMagnitudeName = UNDEFINED_STRING_VALUE;
	_secondMagnitudeName = UNDEFINED_STRING_VALUE;
}

- (NSMutableArray *)mutableKeys
{
	NSMutableArray *keys = [super mutableKeys];
	[keys addObjectsFromArray:@[@"firstMagnitudeName", @"secondMagnitudeName"]];
	return keys;
}

- (NSString *)valueDescription
{
	return [self description];
}

- (NSString *)description
{
	NSMutableString *s = [NSMutableString stringWithFormat:@"%@ - %@ = ", 
						  self.firstMagnitudeName, self.secondMagnitudeName];
	
	if (self.value == NOT_A_SCIENTIFIC_NUMBER) {
		[s appendString:@"?"];
	}
	else {
		[s appendFormat:@"%g", self.value];
		if (self.errorValue != NOT_A_SCIENTIFIC_NUMBER) {
			[s appendFormat:@" ± %g", self.errorValue];
		}
	}
	return [s copy];	
}

@end





