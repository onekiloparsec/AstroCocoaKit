//
//  STLAstronomicalParallax.h
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"
#import "KPCAstronomicalDistance.h"
#import "KPCSIMBADVOTableValueSetting.h"

@interface KPCAstronomicalParallax : KPCAstronomicalInfo <KPCSIMBADVOTableValueSetting>

- (KPCAstronomicalDistance *)distance;

@end
