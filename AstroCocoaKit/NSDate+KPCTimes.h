//
//  NSDate+STLTimes.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

// Useful category methods to be added to NSDate.

#import <Foundation/Foundation.h>

@interface NSDate (KPCTimes)

/// Returns the decimal UT hour value of the date.
- (double)UTHourValue;

/// Returns the decimal system-clock hour value of the date.
- (double)SystemHourValue;

/// Returns the decimal UT hour value of the date 'now' (at the time of the method call).
+ (double)currentUTHourValue;

/// Returns the decimal system-clock hour value of the date 'now' (at the time of the method call).
+ (double)currentSystemHourValue;

#pragma mark - Julian Dates

/// Returns the julian day of the date.
- (double)julianDay;

/// Returns the modified julian day of the date.
- (double)modifiedJulianDay;

/// Returns the julian day of the geometrical midnight hour of the date (longitude: East positive).
- (double)julianDayOfLocalMidnightForLongitude:(double)longitude;

/// Returns the julian day of the geometrical noon hour of the date (longitude: East positive).
- (double)julianDayOfLocalNoonForLongitude:(double)longitude;

// Returns the date corresponding to the input julian day.
+ (NSDate *)dateWithJulianDay:(double)jd;

// Returns the date whose year, month and day components are taken from the date, but the hours is set by hours,
// in the UT reference. See gregorianUTDateForDateWithHourValue() in KPCTimes.h
- (NSDate *)dateWithUTHourValue:(double)hours;

#pragma mark - Local Mean Sidereal Times

// Returns the local mean sidereal time of the date, for the given geometrical earth longitude (East positive).
- (double)localSiderealTimeForLongitude:(double)aLongitude;

#pragma mark - Sun Altitude

- (double)sunAltitudeForLongitude:(double)longitude latitude:(double)latitude;
- (double)sunAltitudeAtLocalMidnightForLongitude:(double)longitude latitude:(double)latitude;
- (double)sunAltitudeAtLocalNoonForLongitude:(double)longitude latitude:(double)latitude;

#pragma mark - Utilities

- (NSString *)descriptionWithTimeZone:(NSTimeZone *)tz;
- (NSString *)YMDString;

@end
