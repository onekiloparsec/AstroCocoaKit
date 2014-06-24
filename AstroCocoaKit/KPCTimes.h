//
//  KPCTimes.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

// We use Jean Meeus' convention stating that we should use the word 'Day' for the Julian Day (i.e. a single number),
// and not a date (which is an object with components).
// Similar remarks can be fone for using UT (Universal Time) instead of 'UTC'.

#import <Foundation/Foundation.h>

// --- Dates ---

/// Returns a gregorian date object whose date components are expressed in the UT reference.
CFGregorianDate gregorianUTDateForDate(NSDate *date);

/// Returns a gregorian date object whose date components are expressed in the UT reference.
/// The input date is built by combining the year, month and day of 'date' and using the 'hour' for the
/// hour, minutes and seconds components.
CFGregorianDate gregorianUTDateForDateWithHourValue(NSDate *date, double hour);


// --- Julian Days ---

/// Returns the julian day corresponding to the input date.
double julianDayForDate(NSDate *date);

/// Returns the julian day corresponding to the input gregorian date.
double julianDayForGregorianDate(CFGregorianDate date);

/// Returns the modified julian day corresponding to the input date.
double modifiedJulianDayForDate(NSDate *date);

/// Returns the modified julian day corresponding to the input gregorian date.
double modifiedJulianDayForJulianDay(double jd);

/// Returns the julian day of the corresponding epoch, expressed in average julian year (365.25 days).
double julianDayForEpoch(double epoch);

/// Returns the julian century corresponding to the input julian day.
double julianCenturyForJulianDay(double jd);

/// Returns the julian century corresponding to the input date.
double julianCenturyForDate(NSDate *aDate);

/// Returns the decimal hour value of the UT date corresponding to the input julian day.
double UTHoursFromJulianDay(double jd);

/// Returns the date corresponding to the input julian day.
NSDate *dateFromJulianDay(double jd);

/// Returns the date corresponding to the input modified julian day.
NSDate *dateFromModifiedJulianDay(double mjd);

/// Returns the gregorian date corresponding to the input julian day.
CFGregorianDate gregorianDateForJulianDay(double jd);


// --- Local Mean Sidereal Times ---

/// Returns the local mean sidereal times for the given julian day and earth geometrical longitude (positive East).
double localSiderealTimeForJulianDayLongitude(double jd, double longitude);

/// Returns the local mean sidereal times for the given date and earth geometrical longitude (positive East).
double localSiderealTimeForDateLongitude(NSDate *date, double longitude);

/// Returns the local mean sidereal times for the given gregorian date and earth geometrical longitude (positive East).
double localSiderealTimeForGregorianDateLongitude(CFGregorianDate date, double longitude);

