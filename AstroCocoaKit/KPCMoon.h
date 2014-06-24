//
//  STLMoon.h
//  iObserve
//
//  Created by Soft Tenebras Lux on 19/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import "KPCTerrestrialCoordinates.h"
#import "KPCAstronomicalCoordinates.h"

double moonLongitudePeriodicTerms(double D, double M, double Mprime, double Lprime, double F, double julianDay);
double moonLatitudePeriodicTerms(double D, double M, double Mprime, double Lprime, double F, double julianDay);
double moonDistancePeriodicTerms(double D, double M, double Mprime, double F, double julianDay);

double moonMeanLongitude(double T); // Lprime
double moonMeanElongation(double julianDay); // 
double moonMeanAnomaly(double julianDay);
double moonArgumentOfLatitude(double julianDay);

KPCAstronomicalCoordinates *moonCoordinatesForJulianDay(double aJulianDay); // AA
KPCCoordinatesComponents moonCoordinatesElementsForJulianDay(double julianDay);

double moonAltitudeForJulianDate(double aJulianDate, KPCTerrestrialCoordinates *obsCoords);
double moonAzimuthForJulianDate(double aJulianDate, KPCTerrestrialCoordinates *obsCoords);

double julianDateForMoonLunationAndPhase(int aMoonLunation, int aMoonPhase);

double moonAgeForJulianDate(double aJulianDate);
double moonAgeForDate(NSDate *aDate);

NSString *formattedMoonAgeForJulianDate(double aJulianDate);
NSString *formattedMoonAgeForDate(NSDate *aDate);

double moonIlluminationFractionForJulianDay(double julianDay); // AA

double moonRiseUTHourForDateAtObservatory(NSDate *aDate, KPCTerrestrialCoordinates *obsCoords); 
double moonSetUTHourForDateAtObservatory(NSDate *aDate, KPCTerrestrialCoordinates *obsCoords);
