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
@property(nonatomic, assign) KPCAstronomicalCoordinatesComponents equatorialComponents;
@end

@implementation KPCAstroCoordsComponentsTest

- (void)setUp
{
    self.equatorialComponents = KPCMakeAstronomicalCoordinatesComponents(12.0242,
                                                                         -30.345,
                                                                         KPCCoordinatesUnitsHoursAndDegrees,
                                                                         2014.02,
                                                                         KPCAstronomicalCoordinatesSystemEquatorial);
}

- (void)tearDown
{
    self.equatorialComponents = NULL;
}

- (void)testStandardEpoch
{
	XCTAssertTrue(KPCJulianEpochStandard() == STANDARD_JULIAN_EPOCH, @"Wrong standard epoch");
}

- (void)testMakeComponents
{
	XCTAssertTrue(self.equatorialComponents.base.theta == 12.0242, @"Wrong component storage");
	XCTAssertTrue(self.equatorialComponents.base.phi == -30.345, @"Wrong component storage");
	XCTAssertTrue(self.equatorialComponents.base.units == KPCCoordinatesUnitsHoursAndDegrees, @"Wrong component storage");
	XCTAssertTrue(self.equatorialComponents.epoch == 2014.02, @"Wrong component storage");
	XCTAssertTrue(self.equatorialComponents.system == KPCAstronomicalCoordinatesSystemEquatorial, @"Wrong component storage");
}

- (void)testPrecessionInputWithNonEquatorialSystem
{
    self.equatorialComponents.system = KPCAstronomicalCoordinatesSystemCelestial;
    
	XCTAssertThrows(KPCPrecessEquatorialCoordinatesComponents(&c1, &c2, 2001.03),
					@"An input system different from Equatorial must throw an exception.");
}

- (void)testPrecessionInputWithEquatorialSystemAndIdenticalEpoch
{
    KPCAstronomicalCoordinatesComponents c2;
    
	XCTAssertNoThrow(KPCPrecessEquatorialCoordinatesComponents(&self.equatorialComponents, &c2, self.equatorialComponents.epoch),
					 @"Providing valid input value must not throw an exception.");

	XCTAssertTrue(self.equatorialComponents.base.theta == c2.base.theta, @"When final epoch is unchanged, output must be unchanged.");
	XCTAssertTrue(self.equatorialComponents.base.phi == c2.base.phi, @"When final epoch is unchanged, output must be unchanged.");
	XCTAssertTrue(self.equatorialComponents.base.units == c2.base.units, @"When final epoch is unchanged, output must be unchanged.");
	XCTAssertTrue(self.equatorialComponents.epoch == c2.epoch, @"When final epoch is unchanged, output must be unchanged.");
	XCTAssertTrue(self.equatorialComponents.system == c2.system, @"When final epoch is unchanged, output must be unchanged.");
}

@end
