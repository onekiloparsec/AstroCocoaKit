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

@property(nonatomic, assign) double rightAscensionValue;
@property(nonatomic, assign) double declinationValue;
@property(nonatomic, assign) double rightAscensionErrorValue;
@property(nonatomic, assign) double declinationErrorValue;

- (NSString *)rightAscensionValueString;
- (NSString *)declinationValueString;

@end
