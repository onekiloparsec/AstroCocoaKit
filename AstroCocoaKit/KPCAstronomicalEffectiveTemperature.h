//
//  STLAstronomicalEffectiveTemperature.h
//  iObserve
//
//  Created by onekiloparsec on 5/11/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

typedef NS_ENUM(NSUInteger, KPCAstronomicalEffectiveTemperatureUnit) {
	KPCAstronomicalEffectiveTemperatureUnitKelvin = 0,
	KPCAstronomicalEffectiveTemperatureUnitCelsius,
};

@interface KPCAstronomicalEffectiveTemperature : KPCAstronomicalInfo

+ (KPCAstronomicalEffectiveTemperature *)temperature:(double)v error:(double)e;

@end
