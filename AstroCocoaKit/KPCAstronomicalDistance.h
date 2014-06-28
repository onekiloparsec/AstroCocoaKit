//
//  STLAstronomicalDistance.h
//  iObserve
//
//  Created by Cédric Foellmi on 24/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

typedef NS_ENUM(NSUInteger, KPCAstronomicalDistanceUnit) {
	KPCAstronomicalDistanceUnitUA,
	KPCAstronomicalDistanceUnitLightYear,	
	KPCAstronomicalDistanceUnitParsec,	
	KPCAstronomicalDistanceUnitKiloParsec,	
	KPCAstronomicalDistanceUnitMegaParsec
};

@interface KPCAstronomicalDistance : KPCAstronomicalInfo

+ (KPCAstronomicalDistance *)distance:(double)v error:(double)e unit:(KPCAstronomicalDistanceUnit)u;

@end
