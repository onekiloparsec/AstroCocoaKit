//
//  KPCAstroCoordsComponentsTest.m
//  iObserve
//
//  Created by onekiloparsec on 16/6/14.
//  Copyright (c) 2014 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPCAstronomicalCoordinatesComponents.h"
#import "KPCScientificConstants.h"

@interface KPCAstroCoordsComponentsTest : XCTestCase

@end

@implementation KPCAstroCoordsComponentsTest

- (void)testStandardEpoch
{
	XCTAssertTrue(KPCJulianEpochStandard() == STANDARD_JULIAN_EPOCH, @"Wrong standard epoch");
}

- (void)testMakeComponents
{
	KPCAstronomicalCoordinatesComponents c = KPCMakeAstronomicalCoordinatesComponents(1.0, 2.1, KPCCoordinatesUnitsHoursAndDegrees, 2014.02, KPCAstronomicalCoordinatesSystemEquatorial);

	XCTAssertTrue(c.base.theta == 1.0, @"Wrong component storage");
	XCTAssertTrue(c.base.phi == 2.1, @"Wrong component storage");
	XCTAssertTrue(c.base.units == KPCCoordinatesUnitsHoursAndDegrees, @"Wrong component storage");
	XCTAssertTrue(c.epoch == 2014.02, @"Wrong component storage");
	XCTAssertTrue(c.system == KPCAstronomicalCoordinatesSystemEquatorial, @"Wrong component storage");
}

- (void)testPrecessionInput
{
	KPCAstronomicalCoordinatesComponents c1, c2;
	c1.base.theta = 12.0242;
	c1.base.phi = -30.345;
	c1.base.units = KPCCoordinatesUnitsHoursAndDegrees;
	c1.epoch = 2001.0345;
	c1.system = KPCAstronomicalCoordinatesSystemCelestial;

	XCTAssertThrows(KPCPrecessEquatorialCoordinatesComponents(&c1, &c2, 2001.03),
					@"An input system different from Equatorial must throw an exception.");

	c1.system = KPCAstronomicalCoordinatesSystemEquatorial;
	XCTAssertNoThrow(KPCPrecessEquatorialCoordinatesComponents(&c1, &c2, 2001.0345),
					 @"Providing valid input value must not throw an exception.");

	XCTAssertTrue(c1.base.theta == c2.base.theta, @"When final epoch is unchanged, output must be unchanged.");
	XCTAssertTrue(c1.base.phi == c2.base.phi, @"When final epoch is unchanged, output must be unchanged.");
	XCTAssertTrue(c1.base.units == c2.base.units, @"When final epoch is unchanged, output must be unchanged.");
	XCTAssertTrue(c1.epoch == c2.epoch, @"When final epoch is unchanged, output must be unchanged.");
	XCTAssertTrue(c1.system == c2.system, @"When final epoch is unchanged, output must be unchanged.");
}

@end
