//
//  KPCTwilightConstants.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import <Foundation/Foundation.h>

static NSUInteger const KPCTwilightModeEnumBegin = 0;

typedef NS_ENUM(NSUInteger, KPCTwilightMode) {
	KPCTwilightModeAstronomical = KPCTwilightModeEnumBegin,
	KPCTwilightModeNautical,
	KPCTwilightModeCivilian,
	KPCTwilightModeSunsetSunrise,
	KPCTwilightModeEnumEnd,
    KPCTwilightModeCount = KPCTwilightModeEnumEnd - KPCTwilightModeEnumBegin
};

extern double const KPCTwilightAstronomicalSunAltitude;
extern double const KPCTwilightNauticalSunAltitude;
extern double const KPCTwilightCivilianSunAltitude;
extern double const KPCTwilightSetRiseSunAltitude;

extern double const KPCTwilightModeAltitudes[KPCTwilightModeCount];

