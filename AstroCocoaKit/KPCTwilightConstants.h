//
//  KPCTwilightConstants.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

typedef NS_ENUM(NSUInteger, KPCTwilightMode) {
    KPCTwilightModeEnumBegin = 0,
	KPCTwilightModeAstronomical = KPCTwilightModeBegin,
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

