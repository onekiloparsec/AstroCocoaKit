//
//  STLAstronomicalCoordinates+Labels.h
//  iObserve
//
//  Created by onekiloparsec on 11/10/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalCoordinates.h"

@interface KPCAstronomicalCoordinates (Labels)

+ (NSString *)rightAscensionLabel;
+ (NSString *)rightAscensionShortLabel;
+ (NSString *)rightAscensionSymbol;
+ (NSString *)declinationLabel;
+ (NSString *)declinationShortLabel;
+ (NSString *)declinationSymbol;

+ (NSString *)celestialLongitudeLabel;
+ (NSString *)celestialLongitudeShortLabel;
+ (NSString *)celestialLongitudeSymbol;
+ (NSString *)celestialLatitudeLabel;
+ (NSString *)celestialLatitudeShortLabel;
+ (NSString *)celestialLatitudeSymbol;

+ (NSString *)galacticLongitudeLabel;
+ (NSString *)galacticLongitudeShortLabel;
+ (NSString *)galacticLongitudeSymbol;
+ (NSString *)galacticLatitudeLabel;
+ (NSString *)galacticLatitudeShortLabel;
+ (NSString *)galacticLatitudeSymbol;

+ (NSString *)localHorizontalAzimuthLabel;
+ (NSString *)localHorizontalAzimuthShortLabel;
+ (NSString *)localHorizontalAzimuthSymbol;
+ (NSString *)localHorizontalAltitudeLabel;
+ (NSString *)localHorizontalAltitudeShortLabel;
+ (NSString *)localHorizontalAltitudeSymbol;

+ (NSString *)rightAscensionComponentLabelForSystem:(KPCAstronomicalCoordinatesSystem)system;
+ (NSString *)rightAscensionComponentShortLabelForSystem:(KPCAstronomicalCoordinatesSystem)system;
+ (NSString *)rightAscensionComponentSymbolForSystem:(KPCAstronomicalCoordinatesSystem)system;

+ (NSString *)declinationComponentLabelForSystem:(KPCAstronomicalCoordinatesSystem)system;
+ (NSString *)declinationComponentShortLabelForSystem:(KPCAstronomicalCoordinatesSystem)system;
+ (NSString *)declinationComponentSymbolForSystem:(KPCAstronomicalCoordinatesSystem)system;

@end
