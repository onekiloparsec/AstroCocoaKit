//
//  STLAstronomicalSpectralType.m
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalSpectralType.h"
#import "KPCAstronomicalInfo+Private.h"

@implementation KPCAstronomicalSpectralType 

+ (KPCAstronomicalSpectralType *)spectralType:(NSString *)st
{
	return [KPCAstronomicalSpectralType infoWithStringValue:st stringUnit:UNDEFINED_STRING_PROPERTY];
}

+ (KPCAstronomicalSpectralType *)spectralType:(NSString *)st bibcode:(NSString *)b
{
	KPCAstronomicalSpectralType *spectype = [KPCAstronomicalSpectralType infoWithStringValue:st stringUnit:UNDEFINED_STRING_PROPERTY];
	spectype.bibcode = b;
	return spectype;
}

- (void)setSIMBADVOTableValue:(NSString *)v forKey:(NSString *)k
{
	if ([v length] == 0) {
		return;
	}

	if ([k isEqualToString:@"SP_TYPE"]) {
		self.stringValue = v;
	}
	else if ([k isEqualToString:@"SP_NATURE"]) {
		if ([v isEqualToString:@"s"]) {
			self.type = KPCAstronomicalSpectralTypeNatureSpectroscopic;
		}
		else if ([v isEqualToString:@"a"]) {
			self.type = KPCAstronomicalSpectralTypeNatureAbsporption;
		}
		else if ([v isEqualToString:@"e"]) {
			self.type = KPCAstronomicalSpectralTypeNatureEmission;
		}
	}
	else if ([k isEqualToString:@"SP_BIBCODE"]) {
		self.bibcode = v;
	}
}

- (NSString *)typeString
{
	NSString *result = nil;
	
	switch (self.type) {
		case KPCAstronomicalSpectralTypeNatureSpectroscopic:
			result = @"spectroscopic";
			break;
		case KPCAstronomicalSpectralTypeNatureAbsporption:
			result = @"absorption";
			break;
		case KPCAstronomicalSpectralTypeNatureEmission:
			result = @"emission";
			break;			
		default:
			result = @"unknown";
			break;
	}
	return result;
}

- (NSString *)valueDescriptionPrefix
{
	return @"spec. type";
}

- (NSString *)valueName
{
	return @"Spectral Type";
}

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit
{
	if (self.type != KPCAstronomicalSpectralTypeNatureUnknown) {
		return [NSString stringWithFormat:@"(%@)", self.typeString];
	}
	return @"";
}

@end
