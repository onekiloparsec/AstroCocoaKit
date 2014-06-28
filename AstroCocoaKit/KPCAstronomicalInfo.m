//
//  STLAstronomicalInfo.m
//  iObserve
//
//  Created by onekiloparsec on 30/7/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalInfo.h"
#import "KPCAstronomicalInfo+Private.h"

@interface NSString (Trimming)
- (NSString *)stringByCleaningLeadingAndTrailingWhiteSpaces;
@end

@implementation NSString (Trimming)
- (NSString *)stringByCleaningLeadingAndTrailingWhiteSpaces
{
    NSMutableString *ms = [self mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)ms);
    return [ms copy];
}
@end

@implementation KPCAstronomicalInfo

- (id)init
{
	self = [super init];
	if (self) {
		[self setup];
	}
	return self;
}

- (void)setup
{
	_value = NOT_A_SCIENTIFIC_NUMBER;
	_errorValue = NOT_A_SCIENTIFIC_NUMBER;
	_unit = NSUIntegerMax;

	_stringValue = nil;
	_stringUnit = nil;
	_wavelength = nil;
	_bibcode = nil;
	_type = NSUIntegerMax;
}

- (id)initWithValue:(double)v error:(double)e units:(NSUInteger)u
{
	self = [self init];
	if (self) {
		_value = v;
		_errorValue = e;
		_unit = u;
		if ([self valueDescriptionUnitCount] > 1) {
			NSAssert(_unit != NSUIntegerMax, @"With multiple units, units property should not be indefined.");
		}
	}
	return self;
}

- (id)initWithStringValue:(NSString *)v stringUnit:(NSString *)u
{
	self = [self init];
	if (self) {
		_stringValue = v;
		_stringUnit = u;
	}
	return self;
}

- (id)initWithBibcode:(NSString *)b wavelength:(NSString *)w type:(NSUInteger)t
{
	self = [self init];
	if (self) {
		_bibcode = b;
		_wavelength = w;
		_type = t;
	}
	return self;
}

+ (instancetype)emptyInfo
{
	return [[[self class] alloc] init];
}

+ (instancetype)infoWithValue:(double)v error:(double)e
{
	KPCAstronomicalInfo *info = (KPCAstronomicalInfo *)[[[self class] alloc] init];
	info.value = v;
	info.errorValue = e;
	if ([info valueDescriptionUnitCount] > 1) {
		info.unit = 0; // Default units is always 0
	}
	return info;
}

+ (instancetype)infoWithValue:(double)v units:(NSUInteger)u
{
	return [[[self class] alloc] initWithValue:v error:NOT_A_SCIENTIFIC_NUMBER units:u];
}

+ (instancetype)infoWithValue:(double)v error:(double)e units:(NSUInteger)u
{
	return [[[self class] alloc] initWithValue:v error:e units:u];
}

+ (instancetype)infoWithStringValue:(NSString *)v stringUnit:(NSString *)u
{
	return [[[self class] alloc] initWithStringValue:v stringUnit:u];
}

+ (instancetype)infoWithBibcode:(NSString *)b wavelength:(NSString *)w type:(NSUInteger)t
{
	return [[[self class] alloc] initWithBibcode:b wavelength:w type:t];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		[self setup];
		[[self mutableKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
			if ([aDecoder containsValueForKey:key]) {
				[self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
			}
		}];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[[self mutableKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
		[aCoder encodeObject:[self valueForKey:key] forKey:key];
	}];
}

- (NSMutableArray *)mutableKeys
{
	return [@[@"value", @"errorValue", @"unit", @"stringValue", @"stringUnit", @"wavelength", @"bibcode", @"type"] mutableCopy];
}

- (double)value:(double)v forUnits:(NSUInteger)anotherUnit
{
	return v;
}

- (NSString *)infoShortString
{
	return @"";
}

- (NSString *)unitString
{
	return [self unitStringForUnits:self.unit];
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	return @"";
}

- (NSString *)typeString
{
	return @"";
}

- (NSString *)valueName
{
	return @"";
}

- (NSUInteger)valueDescriptionUnitCount
{
	return 1;
}

- (NSString *)valueDescriptionPrefix
{
	return @"";
}

- (NSString *)valueDescription
{
	return [self valueDescriptionWithUnits:self.unit];
}

- (NSString *)valueDescriptionWithUnits:(NSUInteger)anotherUnit
{
	NSMutableString *s = [NSMutableString stringWithString:@""];
	if (self.value != NOT_A_SCIENTIFIC_NUMBER && self.value != 0.0) {
		[s appendFormat:@"%g", [self value:self.value forUnits:anotherUnit]];
		if (self.errorValue != NOT_A_SCIENTIFIC_NUMBER && self.errorValue != 0.0) {
			[s appendFormat:@" ± %g", [self value:self.errorValue forUnits:anotherUnit]];
		}
	}
	return [[s copy] stringByCleaningLeadingAndTrailingWhiteSpaces];
}

- (NSString *)valueFullDescription
{
	return [[[self valueDescriptionWithUnits:self.unit] stringByAppendingFormat:@" %@", [self unitString]] stringByCleaningLeadingAndTrailingWhiteSpaces];
}

- (NSString *)valueFullDescriptionWithUnits:(NSUInteger)anotherUnit
{
	return [[[self valueDescriptionWithUnits:anotherUnit] stringByAppendingFormat:@" %@", [self unitStringForUnits:anotherUnit]] stringByCleaningLeadingAndTrailingWhiteSpaces];
}

- (NSArray *)valueFullDescriptions
{
	if (self.value == NOT_A_SCIENTIFIC_NUMBER || self.value == 0.0) {
		return nil;
	}

	NSMutableArray *descriptions = [NSMutableArray array];
	for (NSUInteger i = 0; i < [self valueDescriptionUnitCount]; i++) {
		[descriptions addObject:[self valueFullDescriptionWithUnits:i]];
	}
	return [NSArray arrayWithArray:descriptions];
}

- (NSString *)description
{
	if ((self.stringValue == nil || [self.stringValue isEqualToString:UNDEFINED_STRING_PROPERTY]) && (self.value == NOT_A_SCIENTIFIC_NUMBER || self.value == 0.0)) {
		return nil;
	}
	NSMutableString *s = [NSMutableString stringWithString:[self valueDescriptionPrefix]];
	[s appendString:@" = "];
	[s appendString:[self valueDescription]];
	if (self.stringValue && [self.stringValue isEqualToString:UNDEFINED_STRING_PROPERTY] == NO) {
		[s appendString:self.stringValue];
	}
	else {
		[s appendFormat:@" %@", [self unitString]];
	}
	return [[s copy] stringByCleaningLeadingAndTrailingWhiteSpaces];
}

@end
