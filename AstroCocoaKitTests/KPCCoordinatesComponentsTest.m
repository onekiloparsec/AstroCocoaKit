//
//  KPCCoordinatesComponentsTest.m
//  iObserve
//
//  Created by onekiloparsec on 15/6/14.
//  Copyright (c) 2014 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPCCoordinatesComponents.h"
#import "KPCScientificConstants.h"

@interface KPCCoordinatesComponentsTest : XCTestCase
@end

@implementation KPCCoordinatesComponentsTest

- (void)testMakeWithEmptyAndWrongDataInput
{
	KPCCoordinatesComponents c = KPCMakeCoordinatesComponents(nil);
	XCTAssertTrue(c.theta == NOT_A_SCIENTIFIC_NUMBER, @"Wrong component.");
	XCTAssertTrue(c.phi == NOT_A_SCIENTIFIC_NUMBER, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsUndefined, @"Wrong component.");

	NSData *data = [@"toto" dataUsingEncoding:NSASCIIStringEncoding];
	c = KPCMakeCoordinatesComponents(data);
	XCTAssertTrue(c.theta == NOT_A_SCIENTIFIC_NUMBER, @"Wrong component.");
	XCTAssertTrue(c.phi == NOT_A_SCIENTIFIC_NUMBER, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsUndefined, @"Wrong component.");
}

- (void)testMakeWithCorrectDataInput
{
	NSDictionary *dico = @{@"theta":@(0.1), @"phi":@(0.2), @"units":@(KPCCoordinatesUnitsHoursAndDegrees)};
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dico];
	KPCCoordinatesComponents c = KPCMakeCoordinatesComponents(data);
	XCTAssertTrue(c.theta == 0.1, @"Wrong component.");
	XCTAssertTrue(c.phi == 0.2, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsHoursAndDegrees, @"Wrong component.");
}

- (void)testMakeWithCorrectPositiveStringAndNumberInput
{
	// 4 must produce KPCCoordinatesUnitsHours
	KPCCoordinatesComponents c = KPCMakeCoordinatesComponents(@"1.1 2.2 4");
	XCTAssertTrue(c.theta == 1.1, @"Wrong component.");
	XCTAssertTrue(c.phi == 2.2, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsHours, @"Wrong component, units is %lu.", c.units);

	// 400 must fall back to default
	c = KPCMakeCoordinatesComponents(@"3.3 4.4 400");
	XCTAssertTrue(c.theta == 3.3, @"Wrong component.");
	XCTAssertTrue(c.phi == 4.4, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsDefault, @"Wrong component.");

	// 4 must produce KPCCoordinatesUnitsHours
	c = KPCMakeCoordinatesComponents(@[@(1.1), @(2.2), @(4)]);
	XCTAssertTrue(c.theta == 1.1, @"Wrong component.");
	XCTAssertTrue(c.phi == 2.2, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsHours, @"Wrong component, units is %lu.", c.units);

	// 400 must fall back to default
	c = KPCMakeCoordinatesComponents(@[@(3.3), @(4.4), @(400)]);
	XCTAssertTrue(c.theta == 3.3, @"Wrong component.");
	XCTAssertTrue(c.phi == 4.4, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsDefault, @"Wrong component.");
}

- (void)testMakeWithCorrectNegativeZeroStringAndNumberInput
{
	// 4 must produce KPCCoordinatesUnitsHours
	KPCCoordinatesComponents c = KPCMakeCoordinatesComponents(@"-0.1 2.2 4");
	XCTAssertTrue(c.theta == -0.1, @"Wrong component.");
	XCTAssertTrue(c.phi == 2.2, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsHours, @"Wrong component, units is %lu.", c.units);

	c = KPCMakeCoordinatesComponents(@"-0.1 -0.02 3");
	XCTAssertTrue(c.theta == -0.1, @"Wrong component.");
	XCTAssertTrue(c.phi == -0.02, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsRadians, @"Wrong component, units is %lu.", c.units);

	c = KPCMakeCoordinatesComponents(@[@(-0.1), @(2.2), @(4)]);
	XCTAssertTrue(c.theta == -0.1, @"Wrong component.");
	XCTAssertTrue(c.phi == 2.2, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsHours, @"Wrong component, units is %lu.", c.units);

	c = KPCMakeCoordinatesComponents(@[@(-0.1), @(-0.02), @(3)]);
	XCTAssertTrue(c.theta == -0.1, @"Wrong component.");
	XCTAssertTrue(c.phi == -0.02, @"Wrong component.");
	XCTAssertTrue(c.units == KPCCoordinatesUnitsRadians, @"Wrong component, units is %lu.", c.units);
}

- (void)testMakeSexagesimalComponentsWithVariousInputSign
{
    KPCSexagesimalComponents c1 = KPCMakeSexagesimalComponents(1, 2, 3.01);
    XCTAssertTrue(c1.degrees == 1, @"Wrong storage");
    XCTAssertTrue(c1.minutes == 2, @"Wrong storage");
    XCTAssertTrue(c1.seconds == 3.01, @"Wrong storage");
    XCTAssertTrue(c1.sign == 1, @"Wrong sign");

    KPCSexagesimalComponents c2 = KPCMakeSexagesimalComponents(-1, 2, 3.01);
    XCTAssertTrue(c2.degrees == 1, @"Wrong storage");
    XCTAssertTrue(c2.minutes == 2, @"Wrong storage");
    XCTAssertTrue(c2.seconds == 3.01, @"Wrong storage");
    XCTAssertTrue(c2.sign == -1, @"Wrong sign");

    KPCSexagesimalComponents c3 = KPCMakeSexagesimalComponents(0, -2, 3.01);
    XCTAssertTrue(c3.degrees == 0, @"Wrong storage");
    XCTAssertTrue(c3.minutes == 2, @"Wrong storage");
    XCTAssertTrue(c3.seconds == 3.01, @"Wrong storage");
    XCTAssertTrue(c3.sign == -1, @"Wrong sign");
    
    KPCSexagesimalComponents c4 = KPCMakeSexagesimalComponents(0, 0, -3.01);
    XCTAssertTrue(c4.degrees == 0, @"Wrong storage");
    XCTAssertTrue(c4.minutes == 0, @"Wrong storage");
    XCTAssertTrue(c4.seconds == 3.01, @"Wrong storage");
    XCTAssertTrue(c4.sign == -1, @"Wrong sign");

    KPCSexagesimalComponents c5 = KPCMakeSexagesimalComponents(-1, 0, 3.01);
    XCTAssertTrue(c5.degrees == 1, @"Wrong storage");
    XCTAssertTrue(c5.minutes == 0, @"Wrong storage");
    XCTAssertTrue(c5.seconds == 3.01, @"Wrong storage");
    XCTAssertTrue(c5.sign == -1, @"Wrong sign");
    
    KPCSexagesimalComponents c6 = KPCMakeSexagesimalComponents(0, -2, 3.01);
    XCTAssertTrue(c6.degrees == 0, @"Wrong storage");
    XCTAssertTrue(c6.minutes == 2, @"Wrong storage");
    XCTAssertTrue(c6.seconds == 3.01, @"Wrong storage");
    XCTAssertTrue(c6.sign == -1, @"Wrong sign");
    
    KPCSexagesimalComponents c7 = KPCMakeSexagesimalComponents(-4, 0, 0.0);
    XCTAssertTrue(c7.degrees == 4, @"Wrong storage");
    XCTAssertTrue(c7.minutes == 0, @"Wrong storage");
    XCTAssertTrue(c7.seconds == 0.0, @"Wrong storage");
    XCTAssertTrue(c7.sign == -1, @"Wrong sign");
}

- (void)testMakeSexagesimalComponentsFromValue
{
    KPCSexagesimalComponents c1 = KPCMakeSexagesimalComponentsFromValue(1.23456789);
    XCTAssertTrue(c1.degrees == 1, @"Wrong value");
    XCTAssertTrue(c1.minutes == 14, @"Wrong value");
    XCTAssertEqualWithAccuracy(c1.seconds, 266.6642399999, 1e9, @"Wrong value");
    XCTAssertTrue(c1.sign == 1, @"Wrong sign");

    KPCSexagesimalComponents c2 = KPCMakeSexagesimalComponentsFromValue(-2.23456789);
    XCTAssertTrue(c2.degrees == 2, @"Wrong value");
    XCTAssertTrue(c2.minutes == 14, @"Wrong value");
    XCTAssertEqualWithAccuracy(c2.seconds, 266.6642399999, 1e9, @"Wrong value");
    XCTAssertTrue(c2.sign == -1, @"Wrong sign");
}

- (void)testSexagesimalComponentsConversion
{
    KPCSexagesimalComponents c1 = KPCMakeSexagesimalComponentsFromValue(1.23456789);
    double v1 = KPCSexagesimalComponentsValue(c1);
    XCTAssertEqualWithAccuracy(v1, 1.23456789, 1e9, @"Wrong value");
}

@end
