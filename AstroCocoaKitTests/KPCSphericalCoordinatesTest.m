//
//  SphericalCoordinatesTest.m
//  iObserve
//
//  Created by Soft Tenebras Lux on 18/12/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "KPCScientificConstants.h"
#import "KPCSphericalCoordinates.h"

@interface KPCSphericalCoordinatesTest : XCTestCase
@end


@implementation KPCSphericalCoordinatesTest

- (void)testClassMethodEmptySphericalCoordinates
{
	KPCSphericalCoordinates *coords = [[KPCSphericalCoordinates alloc] init];
	XCTAssertNotNil(coords, @"Spherical Coordinates not created successfully.");
	XCTAssertTrue([coords areEmpty], @"Newly created coordinates not empty.");
}

- (void)testEmptinessSphericalCoordinatesValues
{
	KPCSphericalCoordinates *coords = [KPCSphericalCoordinates emptyCoordinates];
	XCTAssertTrue(([coords theta] == NOT_A_SCIENTIFIC_NUMBER && [coords phi] == NOT_A_SCIENTIFIC_NUMBER), @"Empty Coordinates not really empty.");
}

- (void)testGreatCircleDistanceBetweenTwoEmptyCoordinates
{
	KPCSphericalCoordinates *coords1 = [KPCSphericalCoordinates emptyCoordinates];
	KPCSphericalCoordinates *coords2 = [KPCSphericalCoordinates emptyCoordinates];

	double result = [coords1 greatCircleAngularDistanceToCoordinates:coords2];
	XCTAssertTrue(result == 0, @"Great Circle Distance between two empty coords not 0!");
}

- (void)testGreatCircleDistance
{
	KPCSphericalCoordinates *coords1 = [[KPCSphericalCoordinates alloc] initWithTheta:M_PI/2 phi:0.0 units:KPCCoordinatesUnitsRadians];
	KPCSphericalCoordinates *coords2 = [[KPCSphericalCoordinates alloc] initWithTheta:-M_PI/2 phi:0.0 units:KPCCoordinatesUnitsRadians];

	double degrees1 = [coords1 greatCircleAngularDistanceToCoordinates:coords2];
	XCTAssertEqualWithAccuracy(degrees1*DEG2RAD, M_PI, 1e-12, @"Great Circle Distance between opposite coords not == %f (PI)! Got %f", M_PI, degrees1);

	KPCSphericalCoordinates *coords3 = [[KPCSphericalCoordinates alloc] initWithTheta:M_PI/2 phi:M_PI/2 units:KPCCoordinatesUnitsRadians];
	double degrees2 = [coords3 greatCircleAngularDistanceToCoordinates:coords2];
	XCTAssertEqualWithAccuracy(degrees2*DEG2RAD, M_PI/2, 1e-12, @"Great Circle Distance between coords not == %f (PI/2)! Got %f", M_PI/2, degrees2);
}

- (void)testCoordinatesUnits
{
	KPCSphericalCoordinates *coords = [[KPCSphericalCoordinates alloc] init];
	XCTAssertTrue([coords units] == KPCCoordinatesUnitsRadians, @"Spherical coordinates units not radians by default!");
}

@end
