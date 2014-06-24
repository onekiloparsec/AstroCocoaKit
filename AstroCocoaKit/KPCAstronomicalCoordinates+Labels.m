//
//  STLAstronomicalCoordinates+Labels.m
//  iObserve
//
//  Created by onekiloparsec on 11/10/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCAstronomicalCoordinates+Labels.h"

@implementation KPCAstronomicalCoordinates (Labels)

+ (NSString *)rightAscensionLabel
{
    return @"Right Ascension";
}

+ (NSString *)rightAscensionShortLabel
{
	return @"R.A.";
}

+ (NSString *)rightAscensionSymbol
{
    return @"α";
}

+ (NSString *)declinationLabel
{
    return @"Declination";
}

+ (NSString *)declinationShortLabel
{
	return @"Dec.";
}

+ (NSString *)declinationSymbol
{
    return @"δ";
}

+ (NSString *)celestialLongitudeLabel
{
    return @"Celestial Longitude";
}

+ (NSString *)celestialLongitudeShortLabel
{
	return @"Lon.";
}

+ (NSString *)celestialLongitudeSymbol
{
    return @"λ";
}

+ (NSString *)celestialLatitudeLabel
{
    return @"Celestial Latitude";
}

+ (NSString *)celestialLatitudeShortLabel
{
	return @"Lat.";
}

+ (NSString *)celestialLatitudeSymbol
{
    return @"β";
}

+ (NSString *)galacticLongitudeLabel
{
    return @"Galactic Longitude";
}

+ (NSString *)galacticLongitudeShortLabel
{
	return @"Lon.";
}

+ (NSString *)galacticLongitudeSymbol
{
    return @"l";
}

+ (NSString *)galacticLatitudeLabel
{
    return @"Galactic Latitude";
}

+ (NSString *)galacticLatitudeShortLabel
{
	return @"Lat.";
}

+ (NSString *)galacticLatitudeSymbol
{
    return @"b";
}

+ (NSString *)localHorizontalAzimuthLabel
{
	return @"Local Horizontal Azimuth";
}

+ (NSString *)localHorizontalAzimuthShortLabel
{
	return @"Local Hor. Az.";
}

+ (NSString *)localHorizontalAzimuthSymbol
{
    return @"A";
}

+ (NSString *)localHorizontalAltitudeLabel
{
    return @"Local Horizontal Altitude";
}

+ (NSString *)localHorizontalAltitudeShortLabel
{
	return @"Local Hor. Alt.";
}

+ (NSString *)localHorizontalAltitudeSymbol
{
    return @"h";
}

+ (NSString *)rightAscensionComponentLabelForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			return [KPCAstronomicalCoordinates rightAscensionLabel];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			return [KPCAstronomicalCoordinates celestialLongitudeLabel];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			return [KPCAstronomicalCoordinates galacticLongitudeLabel];
			break;
		case KPCAstronomicalCoordinatesSystemLocalHorizontal:
			return [KPCAstronomicalCoordinates localHorizontalAzimuthLabel];
			break;
		default:
			return @"?";
			break;
	}
}

+ (NSString *)rightAscensionComponentShortLabelForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			return [KPCAstronomicalCoordinates rightAscensionShortLabel];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			return [KPCAstronomicalCoordinates celestialLongitudeShortLabel];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			return [KPCAstronomicalCoordinates galacticLongitudeShortLabel];
			break;
		case KPCAstronomicalCoordinatesSystemLocalHorizontal:
			return [KPCAstronomicalCoordinates localHorizontalAzimuthShortLabel];
			break;
		default:
			return @"?";
			break;
	}
}

+ (NSString *)rightAscensionComponentSymbolForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			return [KPCAstronomicalCoordinates rightAscensionSymbol];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			return [KPCAstronomicalCoordinates celestialLongitudeSymbol];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			return [KPCAstronomicalCoordinates galacticLongitudeSymbol];
			break;
		case KPCAstronomicalCoordinatesSystemLocalHorizontal:
			return [KPCAstronomicalCoordinates localHorizontalAzimuthSymbol];
			break;
		default:
			return @"?";
			break;
	}
}

+ (NSString *)declinationComponentLabelForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			return [KPCAstronomicalCoordinates declinationLabel];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			return [KPCAstronomicalCoordinates celestialLatitudeLabel];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			return [KPCAstronomicalCoordinates galacticLatitudeLabel];
			break;
		case KPCAstronomicalCoordinatesSystemLocalHorizontal:
			return [KPCAstronomicalCoordinates localHorizontalAltitudeLabel];
			break;
		default:
			return @"?";
			break;
	}
}

+ (NSString *)declinationComponentShortLabelForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			return [KPCAstronomicalCoordinates declinationShortLabel];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			return [KPCAstronomicalCoordinates celestialLatitudeShortLabel];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			return [KPCAstronomicalCoordinates galacticLatitudeShortLabel];
			break;
		case KPCAstronomicalCoordinatesSystemLocalHorizontal:
			return [KPCAstronomicalCoordinates localHorizontalAltitudeShortLabel];
			break;
		default:
			return @"?";
			break;
	}
}

+ (NSString *)declinationComponentSymbolForSystem:(KPCAstronomicalCoordinatesSystem)system
{
	switch (system) {
		case KPCAstronomicalCoordinatesSystemEquatorial:
			return [KPCAstronomicalCoordinates declinationSymbol];
			break;
		case KPCAstronomicalCoordinatesSystemCelestial:
			return [KPCAstronomicalCoordinates celestialLatitudeSymbol];
			break;
		case KPCAstronomicalCoordinatesSystemGalactic:
			return [KPCAstronomicalCoordinates galacticLatitudeSymbol];
			break;
		case KPCAstronomicalCoordinatesSystemLocalHorizontal:
			return [KPCAstronomicalCoordinates localHorizontalAltitudeSymbol];
			break;
		default:
			return @"?";
			break;
	}
}

@end
