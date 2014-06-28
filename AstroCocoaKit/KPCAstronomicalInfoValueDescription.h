//
//  STLAstronomicalInfoUnitDescription.h
//  iObserve
//
//  Created by onekiloparsec on 5/11/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KPCAstronomicalInfoValueDescription <NSObject>

- (NSString *)typeString;

- (NSString *)valueName;
- (NSUInteger)valueDescriptionUnitCount;
- (NSString *)valueDescriptionPrefix;

- (NSString *)valueDescription;
- (NSString *)valueFullDescription;
- (NSArray *)valueFullDescriptions;

- (NSString *)unitStringForUnits:(NSUInteger)anotherUnit;
- (NSString *)valueDescriptionWithUnits:(NSUInteger)anotherUnit;
- (NSString *)valueFullDescriptionWithUnits:(NSUInteger)anotherUnit;

@end
