//
//  STLAstronomicalSemiMajorAxis.h
//  iObserve
//
//  Created by Cédric Foellmi on 15/7/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

typedef NS_ENUM(NSUInteger, KPCAstronomicalSemiMajorAxisUnits) {
	KPCAstronomicalSemiMajorAxisUnitsUA = 0,
	KPCAstronomicalSemiMajorAxisUnitsRSun,
	KPCAstronomicalSemiMajorAxisUnitsRStar
};

@interface KPCAstronomicalSemiMajorAxis : KPCAstronomicalInfo

@property(nonatomic, assign) double parentStarRadius;

+ (KPCAstronomicalSemiMajorAxis *)semiMajorAxis:(double)v error:(double)e;

@end

