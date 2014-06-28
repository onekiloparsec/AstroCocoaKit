//
//  STLAstronomicalParallax.m
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalParallax.h"
#import "KPCAstronomicalInfo+Private.h"

@implementation KPCAstronomicalParallax

+ (KPCAstronomicalParallax *)parallaxWithValue:(double)v bibcode:(NSString *)b
{
	KPCAstronomicalParallax *p = [[KPCAstronomicalParallax alloc] init];
	p.value = v;
	p.bibcode = b;
	return p;
}

- (void)setSIMBADVOTableValue:(NSString *)v forKey:(NSString *)k
{
	if ([v length] == 0) {
		return;
	}

	if ([k isEqualToString:@"PLX_VALUE"]) {
		self.value = [v doubleValue];
	}
	else if ([k isEqualToString:@"PLX_ERROR"]) {
		self.errorValue = [v doubleValue];
	}
	else if ([k isEqualToString:@"PLX_BIBCODE"]) {
		self.bibcode = v;
	}
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	return @"mas";
}

- (NSString *)valueName
{
	return @"Geometrical Parallax";
}

- (NSString *)valueDescriptionPrefix
{
	return @"parallax";
}

- (KPCAstronomicalDistance *)distance
{
	return [KPCAstronomicalDistance distance:parsecFromParallax(self.value)
									   error:parsecFromParallax(self.errorValue)
										unit:KPCAstronomicalDistanceUnitParsec];
}

@end
