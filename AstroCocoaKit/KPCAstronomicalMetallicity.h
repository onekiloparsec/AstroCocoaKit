//
//  STLAstronomicalMetallicity.h
//  iObserve
//
//  Created by Cédric Foellmi on 24/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"

typedef NS_ENUM(NSUInteger, KPCAstronomicalMetallicityUnit) {
	KPCAstronomicalMetallicityUnitZ,
	KPCAstronomicalMetallicityUnitFeH
};

@interface KPCAstronomicalMetallicity : KPCAstronomicalInfo

+ (KPCAstronomicalMetallicity *)metallicity:(double)v error:(double)e;

@end
