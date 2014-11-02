//
//  KPCSun.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import <Foundation/Foundation.h>
#import "KPCCoordinatesComponents.h"
#import "KPCAstronomicalCoordinatesComponents.h"

double sunMeanAnomalyForJulianDay(double jd);
double sunMeanLongitudeForJulianDay(double jd);

KPCAstronomicalCoordinatesComponents sunCoordinatesComponentsForJulianDay(double jd);

double sunAzimuthForJulianDayLongitudeLatitude(double jd, double longitude, double latitude);
double sunAltitudeForJulianDayLongitudeLatitude(double jd, double longitude, double latitude);

// Return the julian day of the equinox occuring during the month of march.
double marchEquinoxJulianDayForYear(double y);
