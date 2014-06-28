//
//  STLAstronomicalSpectralType.h
//  TestVOTableXMLParser
//
//  Created by Cédric Foellmi on 15/4/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCAstronomicalInfo.h"
#import "KPCSIMBADVOTableValueSetting.h"

typedef NS_ENUM(NSUInteger, KPCAstronomicalSpectralTypeNature) {
	KPCAstronomicalSpectralTypeNatureUnknown,
	KPCAstronomicalSpectralTypeNatureSpectroscopic,
	KPCAstronomicalSpectralTypeNatureAbsporption,
	KPCAstronomicalSpectralTypeNatureEmission,
};

@interface KPCAstronomicalSpectralType : KPCAstronomicalInfo <KPCSIMBADVOTableValueSetting>

+ (KPCAstronomicalSpectralType *)spectralType:(NSString *)st;

@end
