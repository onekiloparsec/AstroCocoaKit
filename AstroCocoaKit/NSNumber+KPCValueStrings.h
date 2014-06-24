//
//  NSNumber+KPCValueStrings.h
//
//  Created by onekiloparsec on 11/10/13.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import <Foundation/Foundation.h>
#import "KPCCoordinatesComponents.h"

// Summary of name conventions.
// Short   = no seconds value.
// Compact = no white space, ':' separator, no symbols.
// Smart   = show minutes and seconds only if > 0.0, with %g format.

@interface NSNumber (KPCValueStrings)

// --- Sexagesimal Components ---

// Returns the sexagesimal components of the double value.
- (KPCSexagesimalComponents)sexagesimalComponents;

// Returns the sexagesimal components numbers of the double value.
- (NSArray *)sexagesimalComponentsNumbers;

// Returns the sexagesimal components strings of the double value (3 digits for the seconds).
- (NSArray *)sexagesimalComponentsStrings;


// --- Sexagesimal Full Strings ---

// Returns a sexagesimal representation of the double value, with symbols, for the given units, possibly showing symbols.
- (NSString *)sexagesimalString:(KPCCoordinatesUnits)units withDigits:(NSUInteger)count showSymbols:(BOOL)symbols;

// Returns the sexagesimal representation of the double value, with symbols, assuming it is an input hour.
- (NSString *)sexagesimalHourString;

// Returns the sexagesimal representation of the double value, with symbols, assuming it is an input degree.
- (NSString *)sexagesimalDegreeString;

// Returns the sexagesimal representation of the double value, with symbols but no seconds,
// assuming it is an input hour.
- (NSString *)sexagesimalHourShortString;

// Returns the sexagesimal representation of the double value, with symbols but no seconds,
// assuming it is an input degrees.
- (NSString *)sexagesimalDegreeShortString;


// --- Sexagesimal Smart Strings ---

// Returns the smart sexagesimal representation of the double value, with symbols, assuming it is an input hour.
// The minutes and seconds components are shown only if non-zero.
- (NSString *)sexagesimalHourSmartString;

// Returns the smart sexagesimal representation of the double value, with symbols, assuming it is an input degree.
// The minutes and seconds components are shown only if non-zero.
- (NSString *)sexagesimalDegreeSmartString;

// Returns the smart sexagesimal representation of the double value, with symbols, assuming it is an input hour.
// The minutes component is shown only if non-zero. The seconds are never shown.
- (NSString *)sexagesimalHourSmartShortString;

// Returns the smart sexagesimal representation of the double value, with symbols, assuming it is an input degree.
// The minutes component is shown only if non-zero. The seconds are never shown.
- (NSString *)sexagesimalDegreeSmartShortString;


// --- Sexagesimal Compact Strings ---

// Returns the sexagesimal representation of the double value, no white spaces, with ':' as separator.
- (NSString *)sexagesimalCompactString;

// Returns the sexagesimal representation of the double value, without the seconds,
// no white spaces, with ':' as separator.
- (NSString *)sexagesimalCompactShortString;


// --- Decimal Strings ---

// Returns the decimal representation of the double value, with the symbol, using the input count of digits.
- (NSString *)decimalString:(KPCCoordinatesUnits)units withDigits:(NSUInteger)count;

@end
