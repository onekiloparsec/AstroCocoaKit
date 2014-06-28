//
//  STLAstronomicalFlux.h
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"
#import "KPCSIMBADVOTableValueSetting.h"

@interface KPCAstronomicalFlux : KPCAstronomicalInfo <KPCSIMBADVOTableValueSetting>

@property(nonatomic, copy, readonly) NSString *name;

+ (KPCAstronomicalFlux *)fluxWithValue:(double)v name:(NSString *)n bibcode:(NSString *)bibcode;
+ (KPCAstronomicalFlux *)fluxWithValue:(double)v error:(double)e name:(NSString *)n;

@end
