//
//  KPCTimes.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import "KPCTimes.h"
#import "KPCScientificConstants.h"

CFGregorianDate gregorianUTDateForDate(NSDate *date)
{
	NSTimeInterval absoluteTimeOfDate = [date timeIntervalSinceReferenceDate]; // == AbsoluteTime since reference date
	return CFAbsoluteTimeGetGregorianDate((CFTimeInterval)absoluteTimeOfDate, NULL); // tz = NULL = GMT
}

CFGregorianDate gregorianUTDateForDateWithHourValue(NSDate *date, double hour)
{
	hour = fmod(hour+DAY2HOUR, DAY2HOUR); // hour always positive. Make sure we don't change day.
	CFGregorianDate gregorianDate = gregorianUTDateForDate(date);
	gregorianDate.hour = 0;
	gregorianDate.minute = 0;
	gregorianDate.second = 0.0;
	CFAbsoluteTime absTime = CFGregorianDateGetAbsoluteTime(gregorianDate, NULL) + hour*HOUR2SEC;
	return CFAbsoluteTimeGetGregorianDate(absTime, NULL);
}

#pragma mark - Julian Days

double julianDayForDate(NSDate *date)
{
	return julianDayForGregorianDate(gregorianUTDateForDate(date));
}

// Compute the Julian Day from a given date of the Gregorian (usual) calendar.
// see http://scienceworld.wolfram.com/astronomy/JulianDate.html
double julianDayForGregorianDate(CFGregorianDate date)
{
	double year  = (double)date.year;
	double month = (double)date.month; 
	double day   = (double)date.day;	
	double ut    = (double)date.hour + (double)date.minute/MIN2SEC + date.second/HOUR2SEC;
	
	double jd = 367.0*year - floor( 7.0*( year+floor((month+9.0)/12.0))/4.0 ) - 
	floor( 3.0*(floor((year+(month-9.0)/7.0)/100.0) +1.0)/4.0) + 
	floor(275.0*month/9.0) + day + 1721028.5 + ut/24.0;
	
	return jd;	
}

double modifiedJulianDayForDate(NSDate *date)
{
	return modifiedJulianDayForJulianDay(julianDayForDate(date));
}

double modifiedJulianDayForJulianDay(double jd)
{
	return jd - MODIFIED_JULIAN_DAY_ZERO;
}

// See AA, p. 133
double julianDayForEpoch(double epoch)
{
	double julianDaysShift = AVERAGE_JULIAN_YEAR * (epoch - STANDARD_JULIAN_EPOCH);
	return J2000 + julianDaysShift;
}

double julianCenturyForJulianDay(double jd)
{
	return (jd - J2000)/(AVERAGE_JULIAN_YEAR * 100.0);
}

double julianCenturyForDate(NSDate *date)
{
	return julianCenturyForJulianDay(julianDayForDate(date));
}

double UTHoursFromJulianDay(double jd)
{
	CFGregorianDate gregorianDate = gregorianDateForJulianDay(jd);
	return (double)gregorianDate.hour + (double)gregorianDate.minute/MIN2SEC + gregorianDate.second/HOUR2SEC;
}

NSDate *dateFromJulianDay(double jd)
{
	CFGregorianDate refGregorianDate = CFAbsoluteTimeGetGregorianDate(0, NULL); // Reference Gregorian Date. Jan 1 2001 00:00:00 GMT
	double refJulianDay = julianDayForGregorianDate(refGregorianDate);
	double timeInterval = jd - refJulianDay;
	return [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval*DAY2SEC];
}

NSDate *dateFromModifiedJulianDay(double mjd)
{
	return dateFromJulianDay(mjd + MODIFIED_JULIAN_DAY_ZERO);
}

// Compute the date in the Gregorian (usual) calendar from the Julian Day;
// Found in source code of: http://astronomy.villanova.edu/links/jd.htm
CFGregorianDate gregorianDateForJulianDay(double jd)
{
	double X = jd+0.5;
	double Z = floor(X);
	double F = X - Z;
	double Y = floor((Z-1867216.25)/36524.25);
	double A = Z+1+Y-floor(Y/4);
	double B = A+1524;
	double C = floor((B-122.1)/365.25);
	double D = floor(365.25*C);
	double G = floor((B-D)/30.6001);
	double month = (G<13.5) ? (G-1) : (G-13);
	double year = (month<2.5) ? (C-4715) : (C-4716);
	double UT = B-D-floor(30.6001*G)+F;
	double day = floor(UT);
	UT -= floor(UT);
	UT *= 24.0;
	double hour = floor(UT);
	UT -= floor(UT);
	UT *= 60.0;
	double minute = floor(UT);
	UT -= floor(UT);
	UT *= 60.0;
	double second = round(UT);
    
	CFGregorianDate gregDate;
	gregDate.year = (int32_t)year;
	gregDate.month = (int8_t)month;
	gregDate.day = (int8_t)day;
	gregDate.hour = (int8_t)hour;
	gregDate.minute = (int8_t)minute;
	gregDate.second = second;
	
	return gregDate;
}


#pragma mark - Local Sidereal Times

// Ref: Jean Meeus' Astronomical Algorithms, p.88, Equ 12.4
// Return the LMST in hours. No correction for nutation.
double localSiderealTimeForJulianDayLongitude(double jd, double longitude)
{
	double T = julianCenturyForJulianDay(jd);

	// Greenwhich SiderealTime in degrees!
	double gmst = 280.46061837 + 360.98564736629*(jd-J2000) + 0.000387933*T*T - T*T*T/38710000.0;

	while (gmst < 0.) {
		gmst = gmst + 360.0;
	}
	gmst = fmod(gmst, 360.0);

	// Greenwhich SiderealTime in _hours_.
	gmst = gmst * DEG2HOUR;

	// See AA. p92. LMST = theta_0 - L, for L the longitude, if L is positive West.
	// Hence, LMST = theta_0 + L if longitude is positive East, as we have here.
	// That's the only convention of AA we don't follow. Probably should be changed one day.
	double lmst = gmst + longitude*DEG2HOUR;

	// Making sure LMST is positive;
	lmst = fmod(lmst + DAY2HOUR, DAY2HOUR);
	
	return lmst;
}

double localSiderealTimeForDateLongitude(NSDate *date, double longitude)
{
	return localSiderealTimeForJulianDayLongitude(julianDayForDate(date), longitude);
}

double localSiderealTimeForGregorianDateLongitude(CFGregorianDate date, double longitude)
{
	return localSiderealTimeForJulianDayLongitude(julianDayForGregorianDate(date), longitude);
}








