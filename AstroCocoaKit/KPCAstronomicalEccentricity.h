//
//  STLAstronomicalEccentricity.h
//  iObserve
//
//  Created by Cédric Foellmi on 15/7/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

@interface KPCAstronomicalEccentricity : KPCAstronomicalInfo

+ (KPCAstronomicalEccentricity *)eccentricity:(double)v error:(double)e;

@end
