//
//  AstronomicalCoordinatesTest.m
//  iObserve
//
//  Created by Soft Tenebras Lux on 19/12/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "STLNightConstants.h"
#import "KPCScientificConstants.h"
#import "STLAstronomicalCoordinates.h"

@interface AstronomicalCoordinatesTest : XCTestCase
@end


@implementation AstronomicalCoordinatesTest

- (void)testCoordinatesUnits
{
	STLAstronomicalCoordinates *coords = [[STLAstronomicalCoordinates alloc] init];
	XCTAssertTrue([coords units] == KPCCoordinatesUnitsHoursAndDegrees, @"Astronomical coordinates units not degrees!");
	
	[coords setRightAscension:10.];
	[coords setDeclination:-30.];
	
	XCTAssertEqualWithAccuracy(coords.theta, 10.*HOUR2RAD, 1e-12,
							   @"R.A. internal conversion issue. Should be 10.0, got %f", [coords rightAscension]);
	XCTAssertEqualWithAccuracy(coords.phi, -30.*DEG2RAD, 1e-12,
							   @"Dec. internal conversion issue. Should be -30.0, got %f", [coords declination]);

}

- (void)testCoordinatesEpochPrecession
{
	STLAstronomicalCoordinates *coords = [STLAstronomicalCoordinates emptyCoordinatesWithEpoch:2011.2];
	
	XCTAssertTrue([coords epoch] == 2011.2, 
				 @"Storing epoch failed.");
	
	[coords setRightAscension:10.];
	[coords setDeclination:-30.];
	
	STLAstronomicalCoordinates *newCoords = [coords precessedCoordinatesToStandardEpoch];
	
	XCTAssertTrue([newCoords epoch] == KPCJulianEpochStandard(),
				 @"Precessing to standard epoch failed to set new epoch as standard one");
	
	STLAstronomicalCoordinates *backCoords = [newCoords precessedCoordinatesToEpoch:2011.2];
		
	XCTAssertEqualObjects(coords, backCoords,
						 @"Precession back and forth does not end up with equal coords: %@ != %@.",
						 coords, backCoords);
}

- (void)testCoordinatesFormatting
{
	STLAstronomicalCoordinates *coords = [STLAstronomicalCoordinates emptyCoordinates];
	
	[coords setRightAscension:10.52];
	[coords setDeclination:-31.46];
	
	XCTAssertEqualObjects([coords rightAscensionElementsString], @"10h 31m 12.00s",
						 @"R.A. string formatting failed.");

	XCTAssertEqualObjects([coords declinationElementsString], @"-31º 27\' 36.0\"",
						 @"Dec. string formatting failed.");
}

- (void)testNegativeDeclination
{
	STLAstronomicalCoordinates *coords = [STLAstronomicalCoordinates emptyCoordinates];
	[coords setDeclination:-0.2];
		
	XCTAssertEqualObjects([coords declinationElementsString], @"-0º 12\' 00.0\"",
						 @"Dec. string formatting failed.");

	[coords setDeclination:-0.02];
	
	XCTAssertEqualObjects([coords declinationElementsString], @"-0º 01\' 12.0\"",
						 @"Dec. string formatting failed.");

	NSArray *dec1 = [NSArray arrayWithObjects:
					 [NSNumber numberWithDouble:-0.],
					 [NSNumber numberWithDouble:0.],
					 [NSNumber numberWithDouble:-2.45], nil];
	[coords setDeclinationElements:dec1];
	
	XCTAssertEqualObjects([coords declinationElementsString], @"-0º 00\' 02.5\"",
						 @"Dec. string formatting failed.");

	NSArray *dec2 = [NSArray arrayWithObjects:
					 [NSNumber numberWithDouble:0.],
					 [NSNumber numberWithDouble:-0.],
					 [NSNumber numberWithDouble:-1.12], nil];
	[coords setDeclinationElements:dec2];
	
	XCTAssertEqualObjects([coords declinationElementsString], @"-0º 00\' 01.1\"",
						 @"Dec. string formatting failed.");
}

- (void)testPrecessionWithPositiveDeclination
{
	// Theta Persei (AA, p.135)
	NSArray *ra  = [NSArray arrayWithObjects:@"2", @"44", @"11.99", nil];
	NSArray *dec = [NSArray arrayWithObjects:@"49", @"13", @"42.5", nil];
	
	STLAstronomicalCoordinates *coords = [STLAstronomicalCoordinates emptyCoordinates];
	[coords setRightAscensionElements:ra];
	[coords setDeclinationElements:dec];
	
	STLAstronomicalCoordinates *newCoords = [coords precessedCoordinatesToEpoch:2028.8670499657767];
	
	XCTAssertEqualObjects(@"2h 46m 10.34s", [newCoords rightAscensionStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"R.A. precession failed: Should get '2h 46m 10.34s' instead of '%@'.", 
						 [newCoords rightAscensionStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
	
	XCTAssertEqualObjects(@"+49º 20\' 57.2\"", [newCoords declinationStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"Dec. precession failed: Should get '+49º 20\' 57.20\"' instead of '%@'.", 
						 [newCoords declinationStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
	
	STLAstronomicalCoordinates *backCoords = [newCoords precessedCoordinatesToStandardEpoch];

	XCTAssertEqualObjects(@"2h 44m 11.99s", [backCoords rightAscensionStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"R.A. (back) precession failed: Should get '2h 44m 11.99s' instead of '%@'.", 
						 [backCoords rightAscensionStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
	
	XCTAssertEqualObjects(@"+49º 13\' 42.5\"", [backCoords declinationStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"Dec. (back) precession failed: Should get '+49º 13m 42.50s' instead of '%@'.", 
						 [backCoords declinationStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
}

- (void)testPrecessionWithNegativeDeclination
{
	// GRO J1655-40: Equatorial J2000.0
	NSArray *ra  = [NSArray arrayWithObjects:@"16", @"54", @"00.14", nil];
	NSArray *dec = [NSArray arrayWithObjects:@"-39", @"50", @"44.9", nil];
	
	STLAstronomicalCoordinates *coords = [STLAstronomicalCoordinates emptyCoordinates];
	[coords setRightAscensionElements:ra];
	[coords setDeclinationElements:dec];
	
	STLAstronomicalCoordinates *newCoords = [coords precessedCoordinatesToEpoch:2050.0];
	
	XCTAssertEqualObjects(@"16h 57m 27.56s", [newCoords rightAscensionStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"R.A. precession failed: Should get '16h 57m 27.56s' instead of '%@'.", 
						 [newCoords rightAscensionStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);

	XCTAssertEqualObjects(@"-39º 55' 22.2\"", [newCoords declinationStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"Dec. precession failed: Should get '-39º 55' 22.2\"' instead of '%@'.", 
						 [newCoords declinationStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);

	STLAstronomicalCoordinates *backCoords = [newCoords precessedCoordinatesToStandardEpoch];

	XCTAssertEqualObjects(@"16h 54m 00.14s", [backCoords rightAscensionStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"R.A. (back) precession failed: Should get '16h 54m 00.14s' instead of '%@'.", 
						 [backCoords rightAscensionStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
	
	XCTAssertEqualObjects(@"-39º 50' 44.9\"", [backCoords declinationStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"Dec. (back) precession failed: Should get '-39º 50' 44.9\"' instead of '%@'.", 
						 [backCoords declinationStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
}

- (void)testEquatorialToCelestialTransformation
{
	// GRO J1655-40
	NSArray *ra1  = [NSArray arrayWithObjects:@"16", @"54", @"00.14", nil];
	NSArray *dec1 = [NSArray arrayWithObjects:@"-39", @"50", @"44.9", nil];
	
	STLAstronomicalCoordinates *coords1 = [STLAstronomicalCoordinates emptyCoordinates];
	[coords1 setRightAscensionElements:ra1];
	[coords1 setDeclinationElements:dec1];

	XCTAssertEqualObjects(@"256º 48' 30.02\"", [coords1 formattedCelestialLongitudeStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"R.A. to Equ. Longitude transformation failed: Should get '256º 48' 30.02\"' instead of '%@'.", 
						 [coords1 formattedCelestialLongitudeStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
	
	XCTAssertEqualObjects(@"-17º 09' 32.79\"", [coords1 celestialLatitudeStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"Dec. precession failed: Should get '-17º 09' 32.79\"' instead of '%@'.", 
						 [coords1 celestialLatitudeStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);

	// M2
	NSArray *ra2  = [NSArray arrayWithObjects:@"21", @"33", @"27.02", nil];
	NSArray *dec2 = [NSArray arrayWithObjects:@"-00", @"49", @"23.7", nil];
	
	STLAstronomicalCoordinates *coords2 = [STLAstronomicalCoordinates emptyCoordinates];
	[coords2 setRightAscensionElements:ra2];
	[coords2 setDeclinationElements:dec2];

	XCTAssertEqualObjects(@"325º 24' 58.46\"", [coords2 formattedCelestialLongitudeStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"R.A. to Equ. Longitude transformation failed: Should get '325º 24' 58.46\"' instead of '%@'.", 
						 [coords2 formattedCelestialLongitudeStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
	
	XCTAssertEqualObjects(@"+12º 57' 13.89\"", [coords2 celestialLatitudeStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES],
						 @"Dec. precession failed: Should get '+12º 57' 13.89\"' instead of '%@'.", 
						 [coords2 celestialLatitudeStringWithUnits:KPCCoordinatesUnitsHoursAndDegrees includeSymbol:YES]);
}

- (void)testEquatorialToGalacticTransformation
{
	// HD 5980
	NSArray *ra1  = [NSArray arrayWithObjects:@"00", @"59", @"26.5687", nil];
	NSArray *dec1 = [NSArray arrayWithObjects:@"-72", @"09", @"53.911", nil];
	
	STLAstronomicalCoordinates *coords1 = [STLAstronomicalCoordinates emptyCoordinates];
	[coords1 setRightAscensionElements:ra1];
	[coords1 setDeclinationElements:dec1];

	XCTAssertEqualWithAccuracy(302.066007, [coords1 galacticLongitude], 1e-3, @"Galactic longitude transformation failed");
	XCTAssertEqualWithAccuracy(-44.949815, [coords1 galacticLatitude], 1e-3, @"Galactic latitude transformation failed");

	// M2
	NSArray *ra2  = [NSArray arrayWithObjects:@"21", @"33", @"27.02", nil];
	NSArray *dec2 = [NSArray arrayWithObjects:@"-00", @"49", @"23.7", nil];
	
	STLAstronomicalCoordinates *coords2 = [STLAstronomicalCoordinates emptyCoordinates];
	[coords2 setRightAscensionElements:ra2];
	[coords2 setDeclinationElements:dec2];

	XCTAssertEqualWithAccuracy(53.370871, [coords2 galacticLongitude], 1e-3, @"Galactic longitude transformation failed");
	XCTAssertEqualWithAccuracy(-35.769761, [coords2 galacticLatitude], 1e-3, @"Galactic latitude transformation failed");

	// M2 again
	STLAstronomicalCoordinates *coords3 = [STLAstronomicalCoordinates emptyCoordinates];
	[coords3 fillWithGalacticLongitude:53.370871 latitude:-35.769761];

	XCTAssertEqualWithAccuracy(53.370871, [coords3 galacticLongitude], 1e-4, @"Galactic longitude transformation failed");
	XCTAssertEqualWithAccuracy(-35.769761, [coords3 galacticLatitude], 1e-4, @"Galactic latitude transformation failed");
}

- (void)testGalacticStartrackPlot
{
	NSArray *ra1  = [NSArray arrayWithObjects:@"05", @"20", @"49.0", nil];
	NSArray *dec1 = [NSArray arrayWithObjects:@"26", @"59", @"26.0", nil];

	STLAstronomicalCoordinates *coords1 = [STLAstronomicalCoordinates emptyCoordinates];
	[coords1 setRightAscensionElements:ra1];
	[coords1 setDeclinationElements:dec1];

	XCTAssertEqualWithAccuracy(90, [coords1 galacticLatitude], 5, @"Galactic latitude transformation failed");


	STLAstronomicalCoordinates *coords2 = [STLAstronomicalCoordinates emptyCoordinatesWithEpoch:KPCJulianEpochB1950()];
	[coords2 fillWithGalacticLongitude:0 latitude:90];

	XCTAssertEqualWithAccuracy(27.0, [coords2 declination], 5, @"Inverse galactic latitude transformation failed");
}

@end
