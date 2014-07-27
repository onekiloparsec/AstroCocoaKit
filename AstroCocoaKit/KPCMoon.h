//
//  STLMoon.h
//  iObserve
//
//  Created by Soft Tenebras Lux on 19/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import "KPCCoordinatesComponents.h"

double moonLongitudePeriodicTerms(double D, double M, double Mprime, double Lprime, double F, double julianDay);
double moonLatitudePeriodicTerms(double D, double M, double Mprime, double Lprime, double F, double julianDay);
double moonDistancePeriodicTerms(double D, double M, double Mprime, double F, double julianDay);

double moonMeanLongitude(double T); // Lprime
double moonMeanElongation(double julianDay); // 
double moonMeanAnomaly(double julianDay);
double moonArgumentOfLatitude(double julianDay);

KPCCoordinatesComponents moonCoordinatesElementsForJulianDay(double julianDay);

double moonAltitudeForJulianDay(double julianDay, KPCCoordinatesComponents obsCoords);
double moonAzimuthForJulianDay(double julianDay, KPCCoordinatesComponents obsCoords);

double julianDayForMoonLunationAndPhase(int aMoonLunation, int aMoonPhase);

double moonAgeForJulianDay(double julianDay);
double moonAgeForDate(NSDate *aDate);

NSString *formattedMoonAgeForJulianDay(double julianDay);
NSString *formattedMoonAgeForDate(NSDate *aDate);

double moonIlluminationFractionForJulianDay(double julianDay); // AA

double moonRiseUTHourForDateAtObservatory(NSDate *date, KPCCoordinatesComponents obsCoords);
double moonSetUTHourForDateAtObservatory(NSDate *date, KPCCoordinatesComponents obsCoords);
