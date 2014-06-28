//
//  STLAstronomicalEccentricity.m
//  iObserve
//
//  Created by Cédric Foellmi on 15/7/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalEccentricity.h"

@implementation KPCAstronomicalEccentricity

+ (KPCAstronomicalEccentricity *)eccentricity:(double)v error:(double)e
{
	return [KPCAstronomicalEccentricity infoWithValue:v error:e units:NSUIntegerMax];
}

- (NSString *)valueName
{
	return @"Eccentricity";
}

- (NSString *)valueDescriptionPrefix
{
	return @"e";
}

@end

