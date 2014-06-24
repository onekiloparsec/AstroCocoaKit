//
//  KPCTwilights.c
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#include "sunriset.h"

#import "KPCScientificConstants.h"
#import "KPCTwilights.h"
#import "KPCTimes.h"
#import "NSDate+KPCTimes.h"

double dayLengthForDateLongitudeLatitudeAltitudeLimb(NSDate *date, double longitude, double latitude, double altitude, int limb)
{
	CFGregorianDate gregorianDate = gregorianUTDateForDate(date);
	return __daylen__(gregorianDate.year,
					  gregorianDate.month,
					  gregorianDate.day,
					  longitude,
					  latitude,
					  altitude,
					  limb);
}

double dayLengthForDateLongitudeLatitudeMode(NSDate *date, double longitude, double latitude, KPCTwilightMode mode)
{
	int limb = (mode == KPCTwilightSetRiseSunAltitude) ? 1 : 0;
	double altitude = KPCTwilightModeAltitudes[mode];
	CFGregorianDate gregorianDate = gregorianUTDateForDate(date);

	return __daylen__(gregorianDate.year,
					  gregorianDate.month,
					  gregorianDate.day,
					  longitude,
					  latitude,
					  altitude,
					  limb);
}


void twilightJulianDaysForDateLongitudeLatitudeAltitudeLimb(NSDate *date,
															double longitude,
															double latitude,
															double altitude,
															int limb,
															double *jdRise,
															double *jdSet)
{
	double hourRise, hourSet;
	CFGregorianDate gregorianDate = gregorianUTDateForDate(date);
	int result = __sunriset__(gregorianDate.year,
							  gregorianDate.month,
							  gregorianDate.day,
							  longitude,
							  latitude,
							  altitude,
							  limb,
							  &hourRise,
							  &hourSet);

	if (result == 0) {
		NSDate *dateRise = [date dateWithUTHourValue:hourRise];
		NSDate *dateSet = [date dateWithUTHourValue:hourSet];
		*jdRise = [dateRise julianDay];
		*jdSet = [dateSet julianDay];
	}
	else {
		// Should better handle case for result = 1 or -1.
		*jdRise = NOT_A_SCIENTIFIC_NUMBER;
		*jdSet = NOT_A_SCIENTIFIC_NUMBER;
	}
}

double eveningTwilightJulianDayForObservingDateLongitudeLatitudeMode(NSDate *date, double longitude, double latitude, KPCTwilightMode mode)
{
	double jdSet, jdTmp;
	double altitude = KPCTwilightModeAltitudes[mode];
	int limb = (mode == KPCTwilightSetRiseSunAltitude) ? 1 : 0;

	twilightJulianDaysForDateLongitudeLatitudeAltitudeLimb(date,
														   longitude,
														   latitude,
														   altitude,
														   limb,
														   &jdTmp,
														   &jdSet);

	return jdSet;
}

double morningTwilightJulianDayForObservingDateLongitudeLatitudeMode(NSDate *date, double longitude, double latitude, KPCTwilightMode mode)
{
	double jdRise, jdTmp;
	double altitude = KPCTwilightModeAltitudes[mode];
	int limb = (mode == KPCTwilightSetRiseSunAltitude) ? 1 : 0;

	twilightJulianDaysForDateLongitudeLatitudeAltitudeLimb(date,
														   longitude,
														   latitude,
														   altitude,
														   limb,
														   &jdRise,
														   &jdTmp);

	return jdRise;
}
