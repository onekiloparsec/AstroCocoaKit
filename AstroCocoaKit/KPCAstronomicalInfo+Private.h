//
//  STLAstronomicalInfo_Private.h
//  iObserve
//
//  Created by onekiloparsec on 31/10/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

@interface KPCAstronomicalInfo ()

+ (instancetype)emptyInfo;

@property(nonatomic, assign) double value;
@property(nonatomic, assign) double errorValue;
@property(nonatomic, assign) NSUInteger unit;

@property(nonatomic, strong) NSString *stringValue;
@property(nonatomic, strong) NSString *stringUnit;

@property(nonatomic, strong) NSString *bibcode;
@property(nonatomic, strong) NSString *wavelength;
@property(nonatomic, assign) NSUInteger type;

- (void)setup;
- (NSMutableArray *)mutableKeys;
- (double)value:(double)v forUnits:(NSUInteger)anotherUnit;

@end
