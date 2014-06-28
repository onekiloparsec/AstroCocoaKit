//
//  STLAstronomicalMetallicity.m
//  iObserve
//
//  Created by Cédric Foellmi on 24/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalMetallicity.h"

@implementation KPCAstronomicalMetallicity

+ (KPCAstronomicalMetallicity *)metallicity:(double)v error:(double)e
{
	return [KPCAstronomicalMetallicity infoWithValue:v error:e units:KPCAstronomicalMetallicityUnitFeH];
}

- (NSString *)valueName
{
	return @"Metallicity";
}

- (NSString *)valueDescriptionPrefix
{
	return (self.unit == KPCAstronomicalMetallicityUnitFeH) ? @"[Fe/H]" : @"Z";
}

@end
