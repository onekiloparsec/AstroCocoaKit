//
//  STLSkyPosition.h
//  iObserve
//
//  Created by Cédric Foellmi on 1/10/11.
//  Copyright 2011 Soft Tenebras Lux. All rights reserved.
//

#import "KPCSphericalCoordinates.h"

@class KPCTerrestrialCoordinates;
@class KPCAstronomicalCoordinates;


@interface KPCSkyCoordinates : KPCSphericalCoordinates 

+ (KPCSkyCoordinates *)coordinatesWithAzimuth:(double)az altitude:(double)alt;

- (double)azimuth;
- (double)altitude;

- (KPCAstronomicalCoordinates *)astroCoordinatesForJulianDay:(double)jd obsCoordinates:(KPCTerrestrialCoordinates *)obsCoords;

- (double)minimalAzimuthDifference:(KPCSkyCoordinates *)other;
- (double)minimalAzimuthDifferenceSign:(KPCSkyCoordinates *)other;

@end


