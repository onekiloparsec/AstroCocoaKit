//
//  STLAstronomicalAge.h
//  iObserve
//
//  Created by onekiloparsec on 5/11/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

typedef NS_ENUM(NSUInteger, STLAstronomicalAgeUnit) {
	KPCAstronomicalAgeUnitGyr = 0,
	STLAstronomicalAgeUnitMyr,
	STLAstronomicalAgeUnitYr,
};

@interface KPCAstronomicalAge : KPCAstronomicalInfo

+ (KPCAstronomicalAge *)age:(double)v error:(double)e;

@end
