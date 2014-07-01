//
//  KPCAstronomicalInfoTest.m
//  iObserve
//
//  Created by onekiloparsec on 23/6/14.
//  Copyright (c) 2014 onekiloparsec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KPCAstronomicalInfos.h"

@interface KPCAstronomicalInfoTest : XCTestCase
@end

@implementation KPCAstronomicalInfoTest

- (void)testInfoClassDefaultValues
{
	KPCAstronomicalInfo *info = [[KPCAstronomicalInfo alloc] init];
	XCTAssertNotNil(info, @"Basic init of info should work.");

	XCTAssertTrue([info conformsToProtocol:@protocol(NSCoding)], @"Info must conforms to NSCoding");
	XCTAssertTrue([info conformsToProtocol:@protocol(KPCAstronomicalInfoValueDescription)], @"Info must conforms to KPCAstronomicalInfoValueDescription");

	XCTAssertTrue(info.value == NOT_A_SCIENTIFIC_NUMBER, @"Initial value is wrong.");
	XCTAssertTrue(info.errorValue == NOT_A_SCIENTIFIC_NUMBER, @"Initial erro value is wrong.");
	XCTAssertTrue(info.unit == NSUIntegerMax, @"Initial unit value is wrong.");
	XCTAssertNil(info.stringValue, @"Initial stringValue value must be nil.");
	XCTAssertNil(info.stringUnit, @"Initial stringUnit value must be nil.");
	XCTAssertNil(info.bibcode, @"Initial bibcode value must be nil.");
	XCTAssertNil(info.wavelength, @"Initial wavelength value must be nil.");
	XCTAssertTrue(info.type == NSUIntegerMax, @"Initial type value is wrong.");
}

- (void)testInfoValueDescriptionProtocol
{
	KPCAstronomicalInfo *info = [[KPCAstronomicalInfo alloc] init];
    
	XCTAssertNotNil([info typeString], @"Info type string must not be nil.");
	XCTAssertTrue([[info typeString] length] == 0, @"Initial type string must be empty.");

	XCTAssertNotNil([info valueName], @"Info valueName must not be nil.");
	XCTAssertTrue([[info valueName] length] == 0, @"Initial valueName must be empty.");

	XCTAssertTrue([info valueDescriptionUnitCount] == 1, @"Initial valueDescriptionUnitCount must be 1.");

	XCTAssertNotNil([info valueDescriptionPrefix], @"Info valueDescriptionPrefix must not be nil.");
	XCTAssertTrue([[info valueDescriptionPrefix] length] == 0, @"Initial valueDescriptionPrefix must be empty.");

	XCTAssertNotNil([info valueDescription], @"Info valueDescription must not be nil.");
	XCTAssertTrue([[info valueDescription] length] == 0, @"Initial valueDescription must be empty.");

	XCTAssertNotNil([info valueFullDescription], @"Info valueFullDescription must not be nil.");
	XCTAssertTrue([[info valueFullDescription] length] == 0, @"Initial valueFullDescription must be empty.");

	XCTAssertNil([info valueFullDescriptions], @"Info valueFullDescriptions must be nil.");

	XCTAssertNotNil([info valueDescriptionWithUnits:0], @"Info valueDescriptionWithUnits must not be nil.");
	XCTAssertTrue([[info valueDescriptionWithUnits:0] length] == 0, @"Initial valueDescriptionWithUnits must be empty.");

	XCTAssertNil([info description], @"Info description must be nil.");
}

- (void)testMassInfoClass
{
	KPCAstronomicalMass *m0 = [KPCAstronomicalMass infoWithValue:3.1415 error:1.45];
    XCTAssertNotNil(m0, @"Unable to make info.");
    XCTAssertTrue(m0.unit == 0, @"Wrong unit.");

    KPCAstronomicalMass *m1 = [KPCAstronomicalMass solarMass:1.0];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 1.0, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == NOT_A_SCIENTIFIC_NUMBER, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalMassUnitSun, @"Wrong unit.");
    
    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");
    
    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
    
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:4];
    
    KPCAstronomicalMass *m2 = [KPCAstronomicalMass jupiterMass:1.0];
    XCTAssertNotNil(m2, @"Unable to make info.");
    XCTAssertTrue(m2.value == 1.0, @"Wrong info value.");
    XCTAssertTrue(m2.errorValue == NOT_A_SCIENTIFIC_NUMBER, @"Wrong info error value.");
    XCTAssertTrue(m2.unit == KPCAstronomicalMassUnitJupiter, @"Wrong unit.");
    
    XCTAssertNil(m2.stringValue, @"String value must be nil");
    XCTAssertNil(m2.stringUnit, @"String unit must be nil");
    
    XCTAssertNil(m2.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m2.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m2.type == NSUIntegerMax, @"Type should be undefined");
    
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m2 unitsCount:4];
}

- (void)testRadiusInfoClass
{
	KPCAstronomicalRadius *m0 = [KPCAstronomicalRadius infoWithValue:3.1415 error:1.45];
    XCTAssertNotNil(m0, @"Unable to make info.");
    XCTAssertTrue(m0.unit == 0, @"Wrong unit.");

    KPCAstronomicalRadius *m1 = [KPCAstronomicalRadius jupiterRadius:1.2 error:2.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 1.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 2.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalRadiusUnitJupiter, @"Wrong unit.");
    
    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");
    
    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
    
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:4];
    
    KPCAstronomicalRadius *m2 = [KPCAstronomicalRadius solarRadius:3.4 error:4.5];
    XCTAssertNotNil(m2, @"Unable to make info.");
    XCTAssertTrue(m2.value == 3.4, @"Wrong info value.");
    XCTAssertTrue(m2.errorValue == 4.5, @"Wrong info error value.");
    XCTAssertTrue(m2.unit == KPCAstronomicalRadiusUnitSun, @"Wrong unit.");
    
    XCTAssertNil(m2.stringValue, @"String value must be nil");
    XCTAssertNil(m2.stringUnit, @"String unit must be nil");
    
    XCTAssertNil(m2.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m2.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m2.type == NSUIntegerMax, @"Type should be undefined");
    
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m2 unitsCount:4];
}

- (void)testAgeInfoClass
{
	KPCAstronomicalAge *m0 = [KPCAstronomicalAge infoWithValue:3.1415 error:1.45];
    XCTAssertNotNil(m0, @"Unable to make info.");
    XCTAssertTrue(m0.unit == 0, @"Wrong unit.");

    KPCAstronomicalAge *m1 = [KPCAstronomicalAge age:1.2 error:2.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 1.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 2.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalAgeUnitGyr, @"Wrong unit.");
    
    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");
    
    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
    
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:3];
}

- (void)testTemperatureInfoClass
{
	KPCAstronomicalEffectiveTemperature *m0 = [KPCAstronomicalEffectiveTemperature infoWithValue:3.1415 error:1.45];
    XCTAssertNotNil(m0, @"Unable to make info.");
    XCTAssertTrue(m0.unit == 0, @"Wrong unit.");

    KPCAstronomicalEffectiveTemperature *m1 = [KPCAstronomicalEffectiveTemperature temperature:1.2 error:2.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 1.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 2.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalEffectiveTemperatureUnitKelvin, @"Wrong unit.");
    
    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");
    
    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
    
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:2];
}

- (void)testMetallicityInfoClass
{
    KPCAstronomicalMetallicity *m1 = [KPCAstronomicalMetallicity metallicity:1.2 error:2.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 1.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 2.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalMetallicityUnitFeH, @"Wrong unit.");
    
    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");
    
    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
    
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:1];
}

- (void)testDistanceInfoClass
{
	KPCAstronomicalDistance *m0 = [KPCAstronomicalDistance infoWithValue:3.1415 error:1.45];
    XCTAssertNotNil(m0, @"Unable to make info.");
    XCTAssertTrue(m0.unit == 0, @"Wrong unit.");

    NSUInteger distanceUnitsMax = 3;
    for (NSUInteger i = 0; i < distanceUnitsMax; i++) {
        KPCAstronomicalDistance *m1 = [KPCAstronomicalDistance distance:1.2+i error:2.3+i*i unit:i];
        
        XCTAssertNotNil(m1, @"Unable to make info.");
        XCTAssertTrue(m1.value == 1.2+i, @"Wrong info value.");
        XCTAssertTrue(m1.errorValue == 2.3+i*i, @"Wrong info error value.");
        XCTAssertTrue(m1.unit == i, @"Wrong unit.");
        
        XCTAssertNil(m1.stringValue, @"String value must be nil");
        XCTAssertNil(m1.stringUnit, @"String unit must be nil");
        
        XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
        XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
        XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
        
        [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:distanceUnitsMax];
    }
}

- (void)testFluxInfoClass
{
    KPCAstronomicalFlux *m1 = [KPCAstronomicalFlux infoWithValue:NOT_A_SCIENTIFIC_NUMBER units:NOT_A_SCIENTIFIC_NUMBER];
	XCTAssertTrue([m1 conformsToProtocol:@protocol(KPCSIMBADVOTableValueSetting)], @"Info must conform to KPCSIMBADVOTableValueSetting protocol");
	XCTAssertTrue(m1.name == UNDEFINED_STRING_VALUE, @"Info must have an undefined string name on init");
}

- (void)testColorInfoClass
{
    KPCAstronomicalColor *m1 = [KPCAstronomicalColor infoWithValue:NOT_A_SCIENTIFIC_NUMBER units:NOT_A_SCIENTIFIC_NUMBER];
	XCTAssertTrue(m1.firstMagnitudeName == UNDEFINED_STRING_VALUE, @"Info must have an undefined string name on init");
	XCTAssertTrue(m1.secondMagnitudeName == UNDEFINED_STRING_VALUE, @"Info must have an undefined string name on init");
}

- (void)testOrbitalPeriodInfoClass
{
	KPCAstronomicalOrbitalPeriod *m0 = [KPCAstronomicalOrbitalPeriod infoWithValue:3.1415 error:1.45];
    XCTAssertNotNil(m0, @"Unable to make info.");
    XCTAssertTrue(m0.unit == 0, @"Wrong unit.");

    KPCAstronomicalOrbitalPeriod *m1 = [KPCAstronomicalOrbitalPeriod orbitalPeriod:9.2 error:9.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalOrbitalPeriodUnitDays, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");

    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:4];
}

- (void)testSemiMajorAxisInfoClass
{
	KPCAstronomicalSemiMajorAxis *m0 = [KPCAstronomicalSemiMajorAxis infoWithValue:3.1415 error:1.45];
    XCTAssertNotNil(m0, @"Unable to make info.");
    XCTAssertTrue(m0.unit == 0, @"Wrong unit.");

    KPCAstronomicalSemiMajorAxis *m1 = [KPCAstronomicalSemiMajorAxis semiMajorAxis:9.2 error:9.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalSemiMajorAxisUnitsUA, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");

	XCTAssertTrue(m1.parentStarRadius == NOT_A_SCIENTIFIC_NUMBER, @"Wrong property value.");

    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:2];

	m1.parentStarRadius = 2.0;
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:3];

	m1.parentStarRadius = NOT_A_SCIENTIFIC_NUMBER;
    [self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:2];
}

- (void)testEccentricityInfoClass
{
    KPCAstronomicalEccentricity *m1 = [KPCAstronomicalEccentricity eccentricity:9.2 error:9.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == NSUIntegerMax, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
}

- (void)testInclinationInfoClass
{
    KPCAstronomicalInclination *m1 = [KPCAstronomicalInclination inclination:9.2 error:9.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == NSUIntegerMax, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
}

- (void)testAngularDistanceInfoClass
{
	KPCAstronomicalAngularDistance *m0 = [KPCAstronomicalAngularDistance infoWithValue:3.1415 error:1.45];
    XCTAssertNotNil(m0, @"Unable to make info.");
    XCTAssertTrue(m0.unit == 0, @"Wrong unit.");

    KPCAstronomicalAngularDistance *m1 = [KPCAstronomicalAngularDistance angularDistance:9.2 error:9.3];
    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalAngularDistanceUnitArcsecond, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");

	[self makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:m1 unitsCount:2];
}

- (void)testParallaxInfoClass
{
    KPCAstronomicalParallax *m1 = [KPCAstronomicalParallax infoWithValue:9.2 error:9.3];

	XCTAssertTrue([m1 conformsToProtocol:@protocol(KPCSIMBADVOTableValueSetting)], @"Info must conform to KPCSIMBADVOTableValueSetting protocol");

    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == NSUIntegerMax, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
}

- (void)testVelocityInfoClass
{
    KPCAstronomicalVelocity *m1 = [KPCAstronomicalVelocity infoWithValue:9.2 error:9.3];

	XCTAssertTrue([m1 conformsToProtocol:@protocol(KPCSIMBADVOTableValueSetting)], @"Flux must conform to KPCSIMBADVOTableValueSetting protocol");

    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == KPCAstronomicalVelocityTypeRadialVelocity, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
}

- (void)testSpectralTypeInfoClass
{
    KPCAstronomicalSpectralType *m1 = [KPCAstronomicalSpectralType infoWithValue:9.2 error:9.3];

	XCTAssertTrue([m1 conformsToProtocol:@protocol(KPCSIMBADVOTableValueSetting)], @"Info must conform to KPCSIMBADVOTableValueSetting protocol");

    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == NSUIntegerMax, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
}

- (void)testMorphologicalTypeInfoClass
{
    KPCAstronomicalMorphologicalType *m1 = [KPCAstronomicalMorphologicalType infoWithValue:9.2 error:9.3];

	XCTAssertTrue([m1 conformsToProtocol:@protocol(KPCSIMBADVOTableValueSetting)], @"Flux must conform to KPCSIMBADVOTableValueSetting protocol");

    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == NSUIntegerMax, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
}

- (void)testProperMotionInfoClass
{
    KPCAstronomicalProperMotion *m1 = [KPCAstronomicalProperMotion infoWithValue:9.2 error:9.3];

	XCTAssertTrue([m1 conformsToProtocol:@protocol(KPCSIMBADVOTableValueSetting)], @"Flux must conform to KPCSIMBADVOTableValueSetting protocol");

    XCTAssertNotNil(m1, @"Unable to make info.");
    XCTAssertTrue(m1.value == 9.2, @"Wrong info value.");
    XCTAssertTrue(m1.errorValue == 9.3, @"Wrong info error value.");
    XCTAssertTrue(m1.unit == NSUIntegerMax, @"Wrong unit.");

    XCTAssertNil(m1.stringValue, @"String value must be nil");
    XCTAssertNil(m1.stringUnit, @"String unit must be nil");

    XCTAssertNil(m1.bibcode, @"Bibcode should be nil");
    XCTAssertNil(m1.wavelength, @"Wavelength should be nil");
    XCTAssertTrue(m1.type == NSUIntegerMax, @"Type should be undefined");
}

- (void)makeAstronomicalInfoValueDescriptionProtocolTestsToValidInfo:(KPCAstronomicalInfo *)info unitsCount:(NSUInteger)count
{
    XCTAssertNotNil(info, @"Info must not be nil.");
    
    XCTAssertNotNil([info typeString], @"Info type string must not be nil.");

    XCTAssertNotNil([info valueName], @"Value name must not be nil.");
    XCTAssertTrue([[info valueName] length] > 0, @"valueName must not be empty.");

    XCTAssertTrue([info valueDescriptionUnitCount] == count, @"Wrong unit count");
    XCTAssertNotNil([info valueDescriptionPrefix], @"Value description prefix must not be nil.");
	XCTAssertTrue([[info valueDescriptionPrefix] length] > 0, @"valueDescriptionPrefix must not be empty.");
    
	XCTAssertNotNil([info valueDescription], @"Info valueDescription must not be nil.");
	XCTAssertTrue([[info valueDescription] length] > 0, @"valueDescription must be empty.");
    
	XCTAssertNotNil([info valueFullDescription], @"Info valueFullDescription must not be nil.");
	XCTAssertTrue([[info valueFullDescription] length] > 0, @"valueFullDescription must not be empty.");
    
	XCTAssertNotNil([info valueFullDescriptions], @"Info valueFullDescriptions must not be nil.");
	XCTAssertTrue([[info valueFullDescriptions] count] == count, @"Info valueFullDescriptions must be of same size of unit count.");
    
    for (NSUInteger i = 0; i < count; i++) {
    	XCTAssertNotNil([info valueDescriptionWithUnits:i], @"Info valueDescriptionWithUnits must not be nil.");
        XCTAssertTrue([[info valueDescriptionWithUnits:i] length] > 0, @"Initial valueDescriptionWithUnits must be empty.");
    }
    
    XCTAssertNotNil([info valueDescriptionWithUnits:count], @"Info valueDescriptionWithUnits must be not nil for invalid units");
    XCTAssertTrue([[info valueDescriptionWithUnits:count] length] > 0, @"Info valueDescriptionWithUnits must be empty for invalid units.");

	XCTAssertNotNil([info description], @"Info description must not be nil.");
}

@end
