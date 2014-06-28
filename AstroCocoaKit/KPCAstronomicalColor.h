//
//  STLAstronomicalColor.h
//  iObserve
//
//  Created by Cédric Foellmi on 1/5/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

@interface KPCAstronomicalColor : KPCAstronomicalInfo

@property(nonatomic, copy) NSString *firstMagnitudeName;
@property(nonatomic, copy) NSString *secondMagnitudeName;

@end
