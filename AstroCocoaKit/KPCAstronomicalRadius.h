//
//  STLAstronomicalRadius.h
//  iObserve
//
//  Created by Cédric Foellmi on 10/25/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

typedef NS_ENUM(NSUInteger, KPCAstronomicalRadiusUnit) {
	KPCAstronomicalRadiusUnitSun,
	KPCAstronomicalRadiusUnitJupiter,
	KPCAstronomicalRadiusUnitNeptune,
	KPCAstronomicalRadiusUnitEarth
};

@interface KPCAstronomicalRadius : KPCAstronomicalInfo

+ (KPCAstronomicalRadius *)jupiterRadius:(double)v error:(double)e;
+ (KPCAstronomicalRadius *)solarRadius:(double)v error:(double)e;

@end
