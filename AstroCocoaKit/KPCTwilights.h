//
//  KPCTwilights.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//  Using algorithms released to the public domain by Paul Schlyter, December 1992
//

#import <Foundation/Foundation.h>
#import "KPCTwilightConstants.h"

// Generic

// Use limb = 1 (or any int != 0) for sunset and sunrise, 0 otherwise.
double dayLengthForDateLongitudeLatitudeAltitudeLimb(NSDate *date,
													 double longitude,
													 double latitude,
													 double altitude,
													 int limb);

void twilightJulianDaysForDateLongitudeLatitudeAltitudeLimb(NSDate *date,
															double longitude,
															double latitude,
															double altitude,
															int limb,
															double *jdRise,
															double *jdSet);

// Specialized

double dayLengthForDateLongitudeLatitudeMode(NSDate *date,
											 double longitude,
											 double latitude,
											 KPCTwilightMode mode);

double eveningTwilightJulianDayForObservingDateLongitudeLatitudeMode(NSDate *date,
																	 double longitude,
																	 double latitude,
																	 KPCTwilightMode mode);

double morningTwilightJulianDayForObservingDateLongitudeLatitudeMode(NSDate *date,
																	 double longitude,
																	 double latitude,
																	 KPCTwilightMode mode);

