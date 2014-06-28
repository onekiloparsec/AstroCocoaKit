//
//  STLAstronomicalInfo.h
//  iObserve
//
//  Created by onekiloparsec on 30/7/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalInfoValueDescription.h"

@interface KPCAstronomicalInfo : NSObject <NSCoding, KPCAstronomicalInfoValueDescription>

@property(nonatomic, assign, readonly) double value;
@property(nonatomic, assign, readonly) double errorValue;
@property(nonatomic, assign, readonly) NSUInteger unit;

@property(nonatomic, strong, readonly) NSString *stringValue;
@property(nonatomic, strong, readonly) NSString *stringUnit;

@property(nonatomic, strong, readonly) NSString *bibcode;
@property(nonatomic, strong, readonly) NSString *wavelength;
@property(nonatomic, assign, readonly) NSUInteger type;

+ (instancetype)infoWithValue:(double)v error:(double)e;
+ (instancetype)infoWithValue:(double)v units:(NSUInteger)u;
+ (instancetype)infoWithValue:(double)v error:(double)e units:(NSUInteger)u;
+ (instancetype)infoWithStringValue:(NSString *)v stringUnit:(NSString *)u;
+ (instancetype)infoWithBibcode:(NSString *)b wavelength:(NSString *)w type:(NSUInteger)t;

@end
