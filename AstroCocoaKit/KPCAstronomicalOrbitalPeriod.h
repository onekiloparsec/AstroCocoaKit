//
//  STLAstronomicalOrbitalPeriod.h
//  iObserve
//
//  Created by Cédric Foellmi on 15/7/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

typedef NS_ENUM(NSUInteger, KPCAstronomicalOrbitalPeriodUnit) {
	KPCAstronomicalOrbitalPeriodUnitDays,
	KPCAstronomicalOrbitalPeriodUnitHours,
	KPCAstronomicalOrbitalPeriodUnitWeeks,
	KPCAstronomicalOrbitalPeriodUnitYears
};

@interface KPCAstronomicalOrbitalPeriod : KPCAstronomicalInfo

+ (KPCAstronomicalOrbitalPeriod *)orbitalPeriod:(double)v error:(double)e;

@end

