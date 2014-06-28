//
//  STLAstronomicalProperMotion.h
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"
#import "KPCSIMBADVOTableValueSetting.h"

@interface KPCAstronomicalProperMotion : KPCAstronomicalInfo <KPCSIMBADVOTableValueSetting>

@property(nonatomic, assign, readonly) double rightAscensionValue;
@property(nonatomic, assign, readonly) double declinationValue;
@property(nonatomic, assign, readonly) double rightAscensionErrorValue;
@property(nonatomic, assign, readonly) double declinationErrorValue;

+ (KPCAstronomicalProperMotion *)properMotionWithRA:(double)ra
											RAError:(double)rae
												dec:(double)dec
										   decError:(double)dece
											bibcode:(NSString *)b;

- (NSString *)rightAscensionValueString;
- (NSString *)declinationValueString;

@end
