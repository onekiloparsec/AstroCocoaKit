//
//  TerrestrialCoordinatesTest.m
//  iObserve
//
//  Created by Soft Tenebras Lux on 18/12/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "KPCScientificConstants.h"
#import "KPCTerrestrialCoordinates.h"

@interface KPCTerrestrialCoordinatesTest : XCTestCase
@end


@implementation KPCTerrestrialCoordinatesTest

- (void)testCoordinatesUnits
{
	KPCTerrestrialCoordinates *coords = [KPCTerrestrialCoordinates coordinatesWithLongitude:10.0 latitude:-30.0 altitude:99.123];
	XCTAssertTrue([coords units] == KPCCoordinatesUnitsDegrees, @"Terrestrial coordinates units not degrees!");

	XCTAssertTrue([coords eastPositive], @"East must be positive");

	XCTAssertEqualWithAccuracy(coords.longitude, 10., 1e-12,
							   @"Longitude internal conversion issue. Should be 10.0, got %f", coords.longitude);
    
	XCTAssertEqualWithAccuracy(coords.latitude, -30., 1e-12,
							   @"Latitude internal conversion issue. Should be -30.0, got %f", coords.latitude);
}

- (void)testGreenwichCoordinates
{
	KPCTerrestrialCoordinates *coords = [KPCTerrestrialCoordinates GreenwichCoordinates];
	XCTAssertTrue([coords longitude] == GREENWICH_LONGITUDE, @"Longitude must be 0.0");
	XCTAssertTrue([coords latitude] == GREENWICH_LATITUDE, @"Latitude is wrong");
	XCTAssertTrue([coords altitude] == GREENWICH_ALTITUDE, @"Altitude is wrong");
}

// See http://www.greatcirclemapper.net/en/great-circle-mapper/route/LFPG-CYUL-SCEL.html
- (void)testGreatCircleDistances
{
	KPCTerrestrialCoordinates *paris    = [KPCTerrestrialCoordinates coordinatesWithLongitude:2.549722222222222 latitude:49.0127777777777 altitude:0.0];
	KPCTerrestrialCoordinates *montreal = [KPCTerrestrialCoordinates coordinatesWithLongitude:-73.7405555555555 latitude:45.4705555555555 altitude:0.0];
	KPCTerrestrialCoordinates *santiago = [KPCTerrestrialCoordinates coordinatesWithLongitude:-70.7855555555555 latitude:-33.39277777777778 altitude:0.0];

	double paris_montreal = [paris greatCircleAngularDistanceToCoordinates:montreal] * DEG2RAD * EARTH_RADIUS_KM;
	double montreal_santiago = [montreal greatCircleAngularDistanceToCoordinates:santiago] * DEG2RAD * EARTH_RADIUS_KM;

	// Accuracy of 100 km... Earth is not a sphere?
	XCTAssertEqualWithAccuracy(paris_montreal, 5440.0, 100.0, @"Wrong great circle distance paris - montreal");
	XCTAssertEqualWithAccuracy(montreal_santiago, 8739.0, 100.0, @"Wrong great circle distance montreal - santiago");
}

@end
