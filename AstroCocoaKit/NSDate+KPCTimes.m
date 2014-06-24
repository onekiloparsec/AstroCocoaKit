//
//  NSDate+STLTimes.m
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import "NSDate+KPCTimes.h"
#import "KPCScientificConstants.h"
#import "KPCTimes.h"
#import "KPCSun.h"

@implementation NSDate (KPCTimes)

- (double)UTHourValue
{
	CFGregorianDate gregDate = [self UTGregorianDate];
	return (double)gregDate.hour + (double)gregDate.minute/MIN2SEC + gregDate.second/HOUR2SEC;
}

- (double)SystemHourValue
{
	CFGregorianDate gregorianDate = [self GregorianDateWithTimeZone:[NSTimeZone systemTimeZone]];
	return (double)gregorianDate.hour + (double)gregorianDate.minute/MIN2SEC + gregorianDate.second/HOUR2SEC;
}

+ (double)currentUTHourValue;
{
	return [[NSDate date] UTHourValue];
}

+ (double)currentSystemHourValue;
{
	return [[NSDate date] SystemHourValue];
}

#pragma mark - Gregorian Dates (Utils)

- (CFGregorianDate)GregorianDateWithTimeZone:(NSTimeZone *)tz
{
	NSTimeInterval absoluteTimeOfDate = [self timeIntervalSinceReferenceDate]; // == AbsoluteTime since reference date
	return CFAbsoluteTimeGetGregorianDate((CFTimeInterval)absoluteTimeOfDate, (__bridge CFTimeZoneRef)tz); // tz = NULL = GMT
}

- (CFGregorianDate)UTGregorianDate
{
	return gregorianUTDateForDate(self);
}

// Create a new date, on the same day, but with a new hour.
- (CFGregorianDate)UTCGregorianDateWithHourValue:(double)hour
{
	hour = fmod(hour+DAY2HOUR, DAY2HOUR); // hour always positive. Make sure we don't change day.
	CFGregorianDate gregorianDate = [self UTGregorianDate];
	gregorianDate.hour = 0;
	gregorianDate.minute = 0;
	gregorianDate.second = 0.0;
	CFAbsoluteTime absTime = CFGregorianDateGetAbsoluteTime(gregorianDate, NULL) + hour*HOUR2SEC;
	return CFAbsoluteTimeGetGregorianDate(absTime, NULL);
}

#pragma mark - Julian Dates

- (double)julianDay
{
	return julianDayForGregorianDate([self UTGregorianDate]);
}

- (double)modifiedJulianDay
{
	return modifiedJulianDayForDate(self);
}

- (double)julianDayOfLocalMidnightForLongitude:(double)longitude // Convention: east positive
{
	double UTHourOfLocalMidnight = longitude * -1 * DEG2HOUR;
	CFGregorianDate gregorianDate = [self UTCGregorianDateWithHourValue:UTHourOfLocalMidnight];
	return julianDayForGregorianDate(gregorianDate);
}

- (double)julianDayOfLocalNoonForLongitude:(double)longitude
{
	return [self julianDayOfLocalMidnightForLongitude:longitude] + 0.5;
}

+ (NSDate *)dateWithJulianDay:(double)jd
{
	CFGregorianDate refGregorianDate = CFAbsoluteTimeGetGregorianDate(0, NULL); // Reference Gregorian Date. Jan 1 2001 00:00:00 GMT
	double refJulianDay = julianDayForGregorianDate(refGregorianDate);
	double timeInterval = jd - refJulianDay;
	return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval*DAY2SEC];
}

- (NSDate *)dateWithUTHourValue:(double)hours
{
	CFGregorianDate gregorianDate = [self UTCGregorianDateWithHourValue:hours];
	CFAbsoluteTime absTime = CFGregorianDateGetAbsoluteTime(gregorianDate, NULL);
	return [NSDate dateWithTimeIntervalSinceReferenceDate:absTime];
}

#pragma mark - SiderealTime

- (double)localSiderealTimeForLongitude:(double)longitude
{
	return localSiderealTimeForJulianDayLongitude([self julianDay], longitude);
}

#pragma mark - Sun

- (double)sunAltitudeForLongitude:(double)longitude latitude:(double)latitude
{
	return sunAltitudeForJulianDayLongitudeLatitude([self julianDay], longitude, latitude);
}

- (double)sunAltitudeAtLocalMidnightForLongitude:(double)longitude latitude:(double)latitude
{
	double jd = [self julianDayOfLocalMidnightForLongitude:longitude];
	return sunAltitudeForJulianDayLongitudeLatitude(jd, longitude, latitude);
}

- (double)sunAltitudeAtLocalNoonForLongitude:(double)longitude latitude:(double)latitude
{
	double jd = [self julianDayOfLocalNoonForLongitude:longitude];
	return sunAltitudeForJulianDayLongitudeLatitude(jd, longitude, latitude);
}

#pragma mark - Utilities

- (NSString *)descriptionWithTimeZone:(NSTimeZone *)tz
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:tz];
	[dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss (ZZZ)"];
	return [dateFormatter stringFromDate:self];
}

- (NSString *)YMDString
{
	return [[[self description] componentsSeparatedByString:@" "] objectAtIndex:0];
}

@end
