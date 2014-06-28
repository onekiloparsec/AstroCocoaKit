//
//  STLAstronomicalMorphologicalType.m
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalMorphologicalType.h"
#import "KPCAstronomicalInfo+Private.h"

@implementation KPCAstronomicalMorphologicalType

- (void)setSIMBADVOTableValue:(NSString *)v forKey:(NSString *)k
{
	if ([v length] == 0) {
		return;
	}

	if ([k isEqualToString:@"MORPH_TYPE"]) {
		self.stringValue = v;
	}
	else if ([k isEqualToString:@"MORPH_BIBCODE"]) {
		self.bibcode = v;
	}
}

- (NSString *)valueDescriptionPrefix
{
	return @"morph. type";
}

- (NSString *)valueName
{
	return @"Morphological Type";
}

@end
