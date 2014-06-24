//
//  MoonTest.m
//  iObserve
//
//  Created by Soft Tenebras Lux on 23/4/11.
//  Copyright 2011 Soft Tenebras Lux. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPCMoon.h"
#import "KPCScientificConstants.h"
#import "KPCSphericalCoordinates.h"
#import "KPCAstronomicalCoordinates.h"

@interface KPCMoonTest : XCTestCase
@end

@implementation KPCMoonTest

- (void)testIlluminationFraction
{
	double JDE = 2448724.5;
	double frac = moonIlluminationFractionForJulianDay(JDE);
	XCTAssertEqualWithAccuracy(frac, (double)0.68, 0.005, @"Moon illum. not correct.");
}

- (void)testCoordinatesPeriodicTerms
{
	// See AA p.342 for the values.
	double JDE = 2448724.5;
	double Lprime = 134.290182;
	double D = 113.842304;
	double M = 97.643514;
	double Mprime = 5.150833;
	double F = 219.889721;
	
	double Epsilonl = moonLongitudePeriodicTerms(D, M, Mprime, Lprime, F, JDE);
	double Epsilonb = moonLatitudePeriodicTerms(D, M, Mprime, Lprime, F, JDE);
	double Epsilonr = moonDistancePeriodicTerms(D, M, Mprime, F, JDE);
		
	XCTAssertEqualWithAccuracy(Epsilonl, (double)-1127527.43656, 0.001, @"Epsilon l not correct.");
	XCTAssertEqualWithAccuracy(Epsilonb, (double)-3229126.42867, 0.001, @"Epsilon b not correct.");
	XCTAssertEqualWithAccuracy(Epsilonr, (double)-16590873.1576, 0.001, @"Epsilon r not correct.");
}

- (void)testMoonCoordinatesComplete
{
	// See AA p.342 for the values.
	double JDE = 2448724.5;
	KPCAstronomicalCoordinates *coords = moonCoordinatesForJulianDay(JDE);

	double RAHour = fmod(134.688470*DEG2HOUR, DAY2HOUR);
	XCTAssertEqualWithAccuracy((double)RAHour, coords.rightAscension, 0.0001, @"Moon R.A. not found.");
	XCTAssertEqualWithAccuracy((double)13.768368, coords.declination, 0.0001, @"Moon Dec. not found.");
}

- (void)testMoonCoordinatesCompleteXephem
{
	double JDE = 2455675.38949;
	KPCAstronomicalCoordinates *coords = moonCoordinatesForJulianDay(JDE);

	XCTAssertEqualWithAccuracy((double)19.4012527777, coords.rightAscension, 0.0001, @"Moon R.A. not found.");
	XCTAssertEqualWithAccuracy((double)-19.460111111, coords.declination, 0.0001, @"Moon Dec. not found.");
}

@end
