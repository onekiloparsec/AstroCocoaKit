//
//  STLAstronomicalInclination.m
//  iObserve
//
//  Created by Cédric Foellmi on 15/7/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInclination.h"

@implementation KPCAstronomicalInclination

+ (KPCAstronomicalInclination *)inclination:(double)v error:(double)e
{
	return [KPCAstronomicalInclination infoWithValue:v error:e];
}

- (NSString *)valueName
{
	return @"Inclination";
}

- (NSString *)valueDescriptionPrefix
{
	return @"i";
}

@end

