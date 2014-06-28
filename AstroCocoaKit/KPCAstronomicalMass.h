//
//  STLAstronomicalMass.h
//  iObserve
//
//  Created by Cédric Foellmi on 24/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

typedef NS_ENUM(NSUInteger, KPCAstronomicalMassUnit) {
	KPCAstronomicalMassUnitSun,
	KPCAstronomicalMassUnitJupiter,
	KPCAstronomicalMassUnitNeptune,
	KPCAstronomicalMassUnitEarth,
};

@interface KPCAstronomicalMass : KPCAstronomicalInfo

+ (KPCAstronomicalMass *)solarMass:(double)v;
+ (KPCAstronomicalMass *)solarMass:(double)v error:(double)e;
+ (KPCAstronomicalMass *)jupiterMass:(double)v;
+ (KPCAstronomicalMass *)jupiterMass:(double)v error:(double)e;

@end
