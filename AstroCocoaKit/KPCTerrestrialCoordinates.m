//
//  STLTerrestrialCoordinates.m
//  iObserve
//
//  Created by Soft Tenebras Lux on 16/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

#import "KPCTerrestrialCoordinates.h"
#import "NSNumber+KPCValueStrings.h"
#import "KPCScientificConstants.h"

@implementation KPCTerrestrialCoordinates

- (id)init
{
	self = [super initWithTheta:NOT_A_SCIENTIFIC_NUMBER phi:NOT_A_SCIENTIFIC_NUMBER units:KPCCoordinatesUnitsDegrees];
	if (self) {
		_altitude = NOT_A_SCIENTIFIC_NUMBER;
	}
	return self;
}

- (id)initWithLongitude:(double)longitude latitude:(double)latitude altitude:(double)altitude
{
	self = [super initWithTheta:longitude phi:latitude units:KPCCoordinatesUnitsDegrees];
	if (self) {
		_altitude = altitude;
	}
	return self;
}

+ (KPCTerrestrialCoordinates *)coordinatesWithLongitude:(double)longitude latitude:(double)latitude altitude:(double)altitude
{
	if (longitude > 180.0) {
		longitude -= 360.0;
	}
	return [[KPCTerrestrialCoordinates alloc] initWithLongitude:longitude latitude:latitude altitude:altitude];
}

+ (KPCTerrestrialCoordinates *)GreenwichCoordinates;
{
	return [[KPCTerrestrialCoordinates alloc] initWithLongitude:GREENWICH_LONGITUDE latitude:GREENWICH_LATITUDE altitude:GREENWICH_ALTITUDE];
}

#pragma mark - NSCoding

- (id)initWithCoder: (NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		_altitude = [(NSNumber *)[coder decodeObjectForKey:@"altitude"] doubleValue];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];
	[coder encodeObject:@(self.altitude) forKey:@"altitude"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    return [[KPCTerrestrialCoordinates allocWithZone:zone] initWithTheta:self.theta phi:self.phi units:self.units];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"long %.5fº, lat %.5fº, alt %.5fm",
			[self longitude], [self latitude], [self altitude]];
}

#pragma mark - Getters and Setters

- (double)longitude
{
	return self.theta;
}

- (double)latitude
{
	return self.phi;
}

- (double)altitude
{
	return _altitude;
}

- (BOOL)eastPositive
{
	return YES;
}

- (NSString *)longitudeElementsString
{
	NSArray *dms = [@(self.longitude) sexagesimalComponentsNumbers];

	NSString *sign  = (self.longitude < 0.0) ? @"-" : @"+";
	NSString *label = (self.longitude < 0.0) ? @"(West)" : @"(East)";

	if (fabs([dms[2] doubleValue]) < 0.01) {
		return [NSString stringWithFormat:@"%@%02iº %02i' 00'' %@",
				sign,
				abs([dms[0] intValue]),
				abs([dms[1] intValue]),
				label];
	}
	else {
		return [NSString stringWithFormat:@"%@%02iº %02i' %04.1f'' %@",
				sign,
				abs([dms[0] intValue]),
				abs([dms[1] intValue]),
				fabs([dms[2] doubleValue]),
				label];
	}
}

- (NSString *)latitudeElementsString
{
	NSArray *dms = [@(self.latitude) sexagesimalComponentsNumbers];

	NSString *sign  = (self.latitude < 0.0) ? @"-" : @"+";
	NSString *label = (self.latitude < 0.0) ? @"(South)" : @"(North)";

	if (fabs([dms[2] doubleValue]) < 0.01) {
		return [NSString stringWithFormat:@"%@%02iº %02i' 00'' %@",
				sign,
				abs([dms[0] intValue]),
				abs([dms[1] intValue]),
				label];
	}
	else {
		return [NSString stringWithFormat:@"%@%02iº %02i' %04.1f'' %@",
				sign,
				abs([dms[0] intValue]),
				abs([dms[1] intValue]),
				fabs([dms[2] doubleValue]),
				label];
	}
}

- (double)UTHoursOfLongitudeLocalMidnight
{
	double ut = [self longitude] * -1.0 * DEG2HOUR;
	if (ut < 0.0) {
		ut += DAY2HOUR;
	}
	return ut;
}

- (NSDictionary *)exportDictionary
{
    NSMutableDictionary *dico = [NSMutableDictionary dictionary];
    [dico setObject:@(self.longitude) forKey:@"longitude"];
    [dico setObject:@(self.latitude) forKey:@"latitude"];
	[dico setObject:@(self.altitude) forKey:@"altitude"];
    return dico;
}

@end
