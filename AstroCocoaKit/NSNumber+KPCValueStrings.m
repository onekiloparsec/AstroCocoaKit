//
//  NSNumber+KPCValueStrings.m
//
//  Created by onekiloparsec on 11/10/13.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import "NSNumber+KPCValueStrings.h"
#import "KPCCoordinatesComponents.h"

@implementation NSNumber (KPCValueStrings)

- (void)getSexagesimalUnits:(double *)d minutes:(double *)m seconds:(double *)s sign:(NSString **)sign
{
	double value = [self doubleValue];
	KPCSexagesimalComponents c = KPCMakeSexagesimalComponentsFromValue(value);
	*d = (double)c.degrees;
	*m = (double)c.minutes;
	*s = c.seconds;

	// Rounding workaround (feels dizzy...)
	// TODO: use NSDecimalNumber everywhere...
	if ([[NSString stringWithFormat:@"%09.6f", c.seconds] doubleValue] == 60.0) {
		*s = 0.0;
		*m += 1.0;
	}
	if (*m == 60.0) {
		*m = 0.0;
		*d += 1.0;
	}

	*sign = (value < 0.0) ? @"-" : @"";
}

#pragma mark - Sexagesimal Components

- (KPCSexagesimalComponents)sexagesimalComponents
{
	return KPCMakeSexagesimalComponentsFromValue([self doubleValue]);
}

- (NSArray *)sexagesimalComponentsNumbers
{
	KPCSexagesimalComponents c = [self sexagesimalComponents];
	return @[@(c.degrees), @(c.minutes), @(c.seconds)];
}

- (NSArray *)sexagesimalComponentsStrings
{
	NSString *sign;
	double d, m, s;
	[self getSexagesimalUnits:&d minutes:&m seconds:&s sign:&sign];

	return @[[NSString stringWithFormat:@"%@%02.0f", sign, d],
			 [NSString stringWithFormat:@"%02.0f", m],
			 [NSString stringWithFormat:@"%06.3f", s]];
}


#pragma mark - Sexagesimal Smart Strings

- (NSString *)sexagesimalSmartString:(KPCCoordinatesUnits)units
{
	NSArray *symbols = KPCSexagesimalCoordinatesSymbols(units);

	NSString *sign;
	double d, m, s;
	[self getSexagesimalUnits:&d minutes:&m seconds:&s sign:&sign];

	NSMutableString *result = [NSMutableString string];
	[result appendFormat:@"%@%g%@", sign, d, symbols[0]];
	if (m > 0.0) {
		[result appendFormat:@" %g%@", m, symbols[1]];
	}
	if (s > 0.0) {
		[result appendFormat:@" %g%@", s, symbols[2]];
	}
	return [result copy];
}


- (NSString *)sexagesimalSmartShortString:(KPCCoordinatesUnits)units
{
	NSArray *symbols = KPCSexagesimalCoordinatesSymbols(units);

	NSString *sign;
	double d, m, s;
	[self getSexagesimalUnits:&d minutes:&m seconds:&s sign:&sign];

	m += round(s/60.0);
	if (m >= 60.0) {
		m = 0.0;
		d += 1.0;
	}

	NSMutableString *result = [NSMutableString string];
	[result appendFormat:@"%@%g%@", sign, d, symbols[0]];
	if (m > 0.0) {
		[result appendFormat:@" %g%@", m, symbols[1]];
	}
	return [result copy];
}

- (NSString *)sexagesimalHourSmartString
{
	return [self sexagesimalSmartString:KPCCoordinatesUnitsHours];
}

- (NSString *)sexagesimalDegreeSmartString
{
	return [self sexagesimalSmartString:KPCCoordinatesUnitsDegrees];
}

- (NSString *)sexagesimalHourSmartShortString
{
	return [self sexagesimalSmartShortString:KPCCoordinatesUnitsHours];
}

- (NSString *)sexagesimalDegreeSmartShortString
{
	return [self sexagesimalSmartShortString:KPCCoordinatesUnitsDegrees];
}


#pragma mark - Sexagesimal Full Strings

- (NSString *)sexagesimalString:(KPCCoordinatesUnits)units withDigits:(NSUInteger)count showSymbols:(BOOL)symbols
{
	NSString *sign;
	double d, m, s;
	[self getSexagesimalUnits:&d minutes:&m seconds:&s sign:&sign];

	NSMutableString *format = [NSMutableString string];
	[format appendString:@"%@%02.0f"]; // units
	if (symbols) {
		[format appendString:@"%@"];
	}
	[format appendString:@" %02.0f "]; // minutes
	if (symbols) {
		[format appendString:@"%@"];
	}

	[format appendString:@" %02."]; // seconds
	[format appendFormat:@"%lu", (unsigned long)count];
	[format appendString:@"f"];
	if (symbols) {
		[format appendString:@"%@"];
	}

	if (symbols) {
		NSArray *symbolsStrings = KPCSexagesimalCoordinatesSymbols(units);
		return [NSString stringWithFormat:format, sign, d, symbolsStrings[0], m, symbolsStrings[1], s, symbolsStrings[2]];
	}
	else {
		return [NSString stringWithFormat:format, sign, d, m, s];
	}
}

- (NSString *)sexagesimalHourString
{
	return [self sexagesimalString:KPCCoordinatesUnitsHours withDigits:2 showSymbols:YES];
}

- (NSString *)sexagesimalDegreeString
{
	return [self sexagesimalString:KPCCoordinatesUnitsDegrees withDigits:1 showSymbols:YES];
}

- (NSString *)sexagesimalShortString:(KPCCoordinatesUnits)units
{
	NSArray *symbols = KPCSexagesimalCoordinatesSymbols(units);

	NSString *sign;
	double d, m, s;
	[self getSexagesimalUnits:&d minutes:&m seconds:&s sign:&sign];

	m += round(s/60.0);
	if (m >= 60.0) {
		m = 0.0;
		d += 1.0;
	}

	NSMutableString *format = [NSMutableString string];
	[format appendString:@"%@%02.0f%@"]; // units
	[format appendString:@" %02.0f%@"]; // minutes

	return [NSString stringWithFormat:format, sign, d, symbols[0], m, symbols[1]];
}

- (NSString *)sexagesimalHourShortString
{
	return [self sexagesimalShortString:KPCCoordinatesUnitsHours];
}

- (NSString *)sexagesimalDegreeShortString
{
	return [self sexagesimalShortString:KPCCoordinatesUnitsDegrees];
}


#pragma mark - Sexagesimal Compacts Strings

- (NSString *)sexagesimalCompactString
{
	NSString *sign;
	double d, m, s;
	[self getSexagesimalUnits:&d minutes:&m seconds:&s sign:&sign];

	return [NSString stringWithFormat:@"%@%02.0f:%02.0f:%02.0f", sign, d, m, s];
}

- (NSString *)sexagesimalCompactShortString
{
	NSString *sign;
	double d, m, s;
	[self getSexagesimalUnits:&d minutes:&m seconds:&s sign:&sign];

	m += round(s/60.0);
	if (m >= 60.0) {
		m = 0.0;
		d += 1.0;
	}

	return [NSString stringWithFormat:@"%@%02.0f:%02.0f", sign, d, m];
}


#pragma mark - Decimal Strings

- (NSString *)decimalString:(KPCCoordinatesUnits)units withDigits:(NSUInteger)count
{
	NSString *symbol = KPCDecimalCoordinatesSymbol(units);
	NSMutableString *format = [NSMutableString stringWithString:@"%."];
	[format appendFormat:@"%lu", (unsigned long)count];
	[format appendString:@"f%@"];
	return [NSString stringWithFormat:format, [self doubleValue], symbol];
}


@end
