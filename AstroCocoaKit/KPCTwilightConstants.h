//
//  KPCTwilightConstants.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

typedef NS_ENUM(NSUInteger, KPCTwilightMode) {
	KPCTwilightModeAstronomical,
	KPCTwilightModeNautical,
	KPCTwilightModeCivilian,
	KPCTwilightModeSunsetSunrise,
};

extern NSUInteger const KPCTwilightModeCount;

extern double const KPCTwilightAstronomicalSunAltitude;
extern double const KPCTwilightNauticalSunAltitude;
extern double const KPCTwilightCivilianSunAltitude;
extern double const KPCTwilightSetRiseSunAltitude;

extern double const KPCTwilightModeAltitudes[4];

#define KPCTwilightModesCount (sizeof(KPCTwilightModeAltitudes)/sizeof(KPCTwilightModeAltitudes[0]))
