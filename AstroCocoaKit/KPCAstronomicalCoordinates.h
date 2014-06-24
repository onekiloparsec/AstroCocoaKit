//
//  STLAstronomicalCoordinates.h
//  iObserve
//
//  Created by Soft Tenebras Lux on 16/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//
//
//  Astronomical coordinates are always stored in equatorial system.
//  By default, units are HMS-DMS, and epoch J2000.
//  Vernal Equinox is always J200 and is fixed. 
//

#import "KPCSphericalCoordinates.h"
#import "KPCAstronomicalCoordinatesComponents.h"

@class KPCTerrestrialCoordinates;

@interface KPCAstronomicalCoordinates : KPCSphericalCoordinates 

@property(nonatomic, assign) KPCAstronomicalCoordinatesSystem displayedSystem;
@property(nonatomic, assign) double displayedEpoch;

// -------------------------------------------------------------------------------------------------
// All-purpose generic constructors
- (id)initWithFirstValue:(double)v1
			 secondValue:(double)v2
				   units:(KPCCoordinatesUnits)units
				inSystem:(KPCAstronomicalCoordinatesSystem)system
				 atEpoch:(double)epoch;

+ (KPCAstronomicalCoordinates *)coordinatesWithComponents:(KPCAstronomicalCoordinatesComponents)components;

// -------------------------------------------------------------------------------------------------
// Accessors
- (double)epoch;
- (KPCAstronomicalCoordinatesSystem)system;
- (NSString *)systemName;

- (double)firstValueForSystem:(KPCAstronomicalCoordinatesSystem)system;
- (double)secondValueForSystem:(KPCAstronomicalCoordinatesSystem)system;

- (NSString *)firstValueStringForSystem:(KPCAstronomicalCoordinatesSystem)system withUnits:(KPCCoordinatesUnits)units;
- (NSString *)secondValueStringForSystem:(KPCAstronomicalCoordinatesSystem)system withUnits:(KPCCoordinatesUnits)units;

- (KPCCoordinatesComponents)componentsForSystem:(KPCAstronomicalCoordinatesSystem)system;

// -------------------------------------------------------------------------------------------------
// Equatorial
+ (KPCAstronomicalCoordinates *)coordinatesWithRightAscension:(double)hours declination:(double)degrees;
+ (KPCAstronomicalCoordinates *)coordinatesWithRightAscension:(double)hours declination:(double)degrees epoch:(double)epoch;
+ (KPCAstronomicalCoordinates *)coordinatesWithRightAscensionElements:(NSArray *)ra declinationElements:(NSArray *)dec;

- (double)rightAscension;
- (double)declination;

- (NSString *)rightAscensionString;
- (NSString *)declinationString;

- (NSString *)rightAscensionStringWithUnits:(KPCCoordinatesUnits)units;
- (NSString *)declinationStringWithUnits:(KPCCoordinatesUnits)units;

// -------------------------------------------------------------------------------------------------
// Celestial
+ (KPCAstronomicalCoordinates *)coordinatesWithCelestialLongitude:(double)lambda latitude:(double)beta;
+ (KPCAstronomicalCoordinates *)coordinatesWithCelestialLongitude:(double)lambda latitude:(double)beta epoch:(double)epoch;

- (double)celestialLongitude;
- (double)celestialLatitude;

- (NSString *)celestialLongitudeString;
- (NSString *)celestialLatitudeString;

- (NSString *)celestialLongitudeStringWithUnits:(KPCCoordinatesUnits)units;
- (NSString *)celestialLatitudeStringWithUnits:(KPCCoordinatesUnits)units;

// -------------------------------------------------------------------------------------------------
// Galactic
+ (KPCAstronomicalCoordinates *)coordinatesWithGalacticLongitude:(double)l latitude:(double)b;
+ (KPCAstronomicalCoordinates *)coordinatesWithGalacticLongitude:(double)lambda latitude:(double)beta epoch:(double)epoch;

- (double)galacticLongitude;
- (double)galacticLatitude;

- (NSString *)galacticLongitudeString;
- (NSString *)galacticLatitudeString;

- (NSString *)galacticLongitudeStringWithUnits:(KPCCoordinatesUnits)units;
- (NSString *)galacticLatitudeStringWithUnits:(KPCCoordinatesUnits)units;

// -------------------------------------------------------------------------------------------------
// Default Horizontal Accessors.
- (double)altitudeForJulianDay:(double)jd observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;
- (double)azimuthForJulianDay:(double)jd observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;

- (NSString *)formattedHorizontalAzimuthWithUnits:(KPCCoordinatesUnits)units
                                          forDate:(NSDate *)aDate
                           observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;

- (NSString *)formattedHorizontalAltitudeWithUnits:(KPCCoordinatesUnits)units
                                           forDate:(NSDate *)aDate
                            observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;

- (NSArray *)horizontalAzimuthStringElementsForDate:(NSDate *)aDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;
- (NSArray *)horizontalAltitudeStringElementsForDate:(NSDate *)aDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;

// -------------------------------------------------------------------------------------------------
- (double)maximumAltitudeForObservatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;
- (double)minimumAltitudeForObservatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;

- (double)hourAngleAtAltitude:(double)anAltitude forObservatoryLatitude:(double)aLatitude;
- (double)angularSeparationToCoordinates:(KPCAstronomicalCoordinates *)starCoords;
- (double)positionAngleToCoordinates:(KPCAstronomicalCoordinates *)starCoords;
- (double)paralacticAngleForJulianDate:(double)aJulianDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;
- (double)hourAngleForJulianDate:(double)aJulianDate observatoryCoordinates:(KPCTerrestrialCoordinates *)obsCoords;

// -------------------------------------------------------------------------------------------------
// Precession
- (KPCAstronomicalCoordinates *)precessedCoordinatesToEpoch:(double)anEpoch;
- (KPCAstronomicalCoordinates *)precessedCoordinatesToDisplayedEpoch;
- (KPCAstronomicalCoordinates *)precessedCoordinatesToCurrentEpoch;
- (KPCAstronomicalCoordinates *)precessedCoordinatesToStandardEpoch;

@end
