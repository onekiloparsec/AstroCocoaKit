//
//  KPCTwilightSet.m
//  iObserve
//
//  Created by onekiloparsec on 21/7/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCTwilightSet.h"
#import "KPCScientificConstants.h"
#import "KPCTimes.h"
#import "KPCTwilights.h"
#import "NSDate+KPCTimes.h"

typedef struct {
	double sunMinimumAltitude;
	double sunMaximumAltitude;
	double eveningJulianDays[4];
	double morningJulianDays[4];
} KPCTwilightCache;

typedef struct {
	double eveningJD;
	double morningJD;
} KPCTwilightJDPair;

KPCTwilightCache KPCMakeEmptyTwilightCache(void);
KPCTwilightCache KPCMakeEmptyTwilightCache(void) {
    KPCTwilightCache cache;
    cache.sunMaximumAltitude = NOT_A_SCIENTIFIC_NUMBER;
    cache.sunMinimumAltitude = NOT_A_SCIENTIFIC_NUMBER;
    cache.eveningJulianDays[0] = NOT_A_SCIENTIFIC_NUMBER;
    cache.eveningJulianDays[1] = NOT_A_SCIENTIFIC_NUMBER;
    cache.eveningJulianDays[2] = NOT_A_SCIENTIFIC_NUMBER;
    cache.eveningJulianDays[3] = NOT_A_SCIENTIFIC_NUMBER;
    cache.morningJulianDays[0] = NOT_A_SCIENTIFIC_NUMBER;
    cache.morningJulianDays[1] = NOT_A_SCIENTIFIC_NUMBER;
    cache.morningJulianDays[2] = NOT_A_SCIENTIFIC_NUMBER;
    cache.morningJulianDays[3] = NOT_A_SCIENTIFIC_NUMBER;
    return cache;
}

@interface KPCTwilightSet () {
	KPCTwilightCache _cache;
	NSDate *_date;
	KPCTerrestrialCoordinates *_coords;
}
@end

@implementation KPCTwilightSet

- (id)initWithNoonDate:(NSDate *)date coordinates:(KPCTerrestrialCoordinates *)coords
{
	self = [super init];
	if (self) {
		// Store a date anyway if we have one.
		_date = date;
		_coords = coords;
        _cache = KPCMakeEmptyTwilightCache();
		[self refreshCachedElements];
	}
	return self;
}

+ (KPCTwilightSet *)twilightSetForNoonDate:(NSDate *)date coordinates:(KPCTerrestrialCoordinates *)coords
{
	return [[KPCTwilightSet alloc] initWithNoonDate:date coordinates:coords];
}

- (NSDate *)noonDate
{
	return _date;
}

- (KPCTerrestrialCoordinates *)inputCoordinates
{
	return _coords;
}

- (void)updateWithNoonDate:(NSDate *)date
{
	_date = date;
	[self refreshCachedElements];
}

- (void)updateWithCoordinates:(KPCTerrestrialCoordinates *)coords
{
	_coords = coords;
	[self refreshCachedElements];
}

- (void)updateWithNoonDate:(NSDate *)date coordinates:(KPCTerrestrialCoordinates *)coords
{
	_date = date;
	_coords = coords;
   	[self refreshCachedElements];
}

- (void)refreshCachedElements
{
    if (_date == nil || _coords == nil || [_coords areEmpty]) {
        _cache = KPCMakeEmptyTwilightCache();
        return;
    }

	_cache.sunMinimumAltitude = [_date sunAltitudeAtLocalMidnightForLongitude:_coords.longitude latitude:_coords.latitude];
	_cache.sunMaximumAltitude = [_date sunAltitudeAtLocalNoonForLongitude:_coords.longitude latitude:_coords.latitude];

	KPCTwilightJDPair pair;
	double midnightJD = [[self noonDate] julianDay] + 0.5;

	for (int i = 0; i < KPCTwilightModeCount; i++) {
		[self twilightsJDPair:&pair forDate:_date mode:(KPCTwilightMode)i];

		if (pair.eveningJD > midnightJD) {
			[self twilightsJDPair:&pair forDate:[_date dateByAddingTimeInterval:-0.5*DAY2SEC] mode:(KPCTwilightMode)i];
		}
		else if (pair.morningJD < midnightJD) {
			[self twilightsJDPair:&pair forDate:[_date dateByAddingTimeInterval:0.5*DAY2SEC] mode:(KPCTwilightMode)i];
		}

		_cache.eveningJulianDays[i] = pair.eveningJD;
		_cache.morningJulianDays[i] = pair.morningJD;
	}
}

- (void)twilightsJDPair:(KPCTwilightJDPair *)pair forDate:(NSDate *)date mode:(KPCTwilightMode)mode
{
	double eveningJD = eveningTwilightJulianDayForObservingDateLongitudeLatitudeMode(date,
																					 _coords.longitude,
																					 _coords.latitude,
																					 mode);

	double morningJD = morningTwilightJulianDayForObservingDateLongitudeLatitudeMode(date,
																					 _coords.longitude,
																					 _coords.latitude,
																					 mode);

	if (morningJD <= eveningJD) {
		morningJD = morningTwilightJulianDayForObservingDateLongitudeLatitudeMode([date dateByAddingTimeInterval:DAY2SEC],
																				  _coords.longitude,
																				  _coords.latitude,
																				  mode);
	}

	if (morningJD != NOT_A_SCIENTIFIC_NUMBER && eveningJD != NOT_A_SCIENTIFIC_NUMBER) {
		NSAssert(morningJD > eveningJD, @"Wrong julian days!");
	}

	if (morningJD == NOT_A_SCIENTIFIC_NUMBER || eveningJD == NOT_A_SCIENTIFIC_NUMBER) {
		(*pair).eveningJD = NOT_A_SCIENTIFIC_NUMBER;
		(*pair).morningJD = NOT_A_SCIENTIFIC_NUMBER;
	}
	else {
		(*pair).eveningJD = eveningJD;
		(*pair).morningJD = morningJD;
	}
}

- (double)sunNightMinimumAltitude
{
	return _cache.sunMinimumAltitude;
}

- (double)sunDayMaximumAltitude
{
	return _cache.sunMaximumAltitude;
}

- (BOOL)hasNight
{
	return (_cache.sunMinimumAltitude != NOT_A_SCIENTIFIC_NUMBER && _cache.sunMinimumAltitude <= KPCTwilightSetRiseSunAltitude);
}

- (NSUInteger)twilightDepthsCount
{
    if (_cache.sunMinimumAltitude == NOT_A_SCIENTIFIC_NUMBER) {
        return 0;
    }
    else if (_cache.sunMinimumAltitude <= KPCTwilightAstronomicalSunAltitude) {
        return 4;
    }
    else if (_cache.sunMinimumAltitude <= KPCTwilightNauticalSunAltitude) {
        return 3;
    }
    else if (_cache.sunMinimumAltitude <= KPCTwilightCivilianSunAltitude) {
        return 2;
    }
    else if (_cache.sunMinimumAltitude <= KPCTwilightSetRiseSunAltitude) {
        return 1;
    }
    else {
        return 0;
    }
}

- (double)eveningTwilightJulianDayForMode:(KPCTwilightMode)mode
{
	return _cache.eveningJulianDays[mode];
}

- (double)morningTwilightJulianDayForMode:(KPCTwilightMode)mode
{
	return _cache.morningJulianDays[mode];
}

//- (STLSmartColor *)skyColorForDate:(NSDate *)date
//{
//    if ([date timeIntervalSinceDate:_date] < 0.0 || [date timeIntervalSinceDate:_date] > DAY2SEC) {
//        return nil;
//    }
//    
//    double jd = julianDayForDate(date);
//    
//    if (jd <= _cache.eveningJulianDays[0] || jd > _cache.morningJulianDays[3]) {
//        return [STLSmartColor daylightColor];
//    }
//    else if (jd <= _cache.eveningJulianDays[1] || jd > _cache.morningJulianDays[2]) {
//        return [STLSmartColor civilianTwilightColor];
//    }
//    else if (jd <= _cache.eveningJulianDays[2] || jd > _cache.morningJulianDays[1]) {
//        return [STLSmartColor nauticalTwilightColor];
//    }
//    else if (jd <= _cache.eveningJulianDays[3] || jd > _cache.morningJulianDays[0]) {
//        return [STLSmartColor astronomicalTwilightColor];
//    }
//
//    return nil;
//}

@end

