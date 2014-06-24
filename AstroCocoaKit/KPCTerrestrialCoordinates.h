//
//  STLTerrestrialCoordinates.h
//  iObserve
//
//  Created by Soft Tenebras Lux on 16/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import "KPCSphericalCoordinates.h"

// CONVENTION: East Positive

@interface KPCTerrestrialCoordinates : KPCSphericalCoordinates {
	double _altitude;
}

+ (KPCTerrestrialCoordinates *)coordinatesWithLongitude:(double)longitude latitude:(double)latitude altitude:(double)altitude;
+ (KPCTerrestrialCoordinates *)GreenwichCoordinates;

- (double)longitude;
- (double)latitude;
- (double)altitude;
- (BOOL)eastPositive;

- (NSString *)longitudeElementsString;
- (NSString *)latitudeElementsString;

- (double)UTHoursOfLongitudeLocalMidnight;

- (NSDictionary *)exportDictionary;


@end
