//
//  KPCAstronomicalCoordinatesComponents.h
//
//  Created by onekiloparsec on 26/10/13.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import <Foundation/Foundation.h>
#import "KPCCoordinatesComponents.h"

typedef NS_ENUM(NSInteger, KPCAstronomicalCoordinatesSystem) {
	KPCAstronomicalCoordinatesSystemEquatorial,
	KPCAstronomicalCoordinatesSystemCelestial,
	KPCAstronomicalCoordinatesSystemGalactic,
	KPCAstronomicalCoordinatesSystemLocalHorizontal
};

typedef NS_ENUM(NSInteger, KPCAstronomicalCoordinatesEpoch) {
	KPCAstronomicalCoordinatesEpochJ2000,
	KPCAstronomicalCoordinatesEpochB1950,
	KPCAstronomicalCoordinatesEpochNow,
	KPCAstronomicalCoordinatesEpochCustom
};

typedef struct KPCAstronomicalCoordinatesComponents {
    KPCCoordinatesComponents base;
    KPCAstronomicalCoordinatesSystem system;
    double epoch;
} KPCAstronomicalCoordinatesComponents;

double KPCJulianEpochStandard(void);
double KPCJulianEpochCurrent(void);
double KPCJulianEpochB1950(void);

NSString *positionAngleString(double value);
NSString *shortPositionAngleString(double value);
NSString *separationAngleString(double value);

NSString *KPCAstronomicalCoordinatesSystemName(KPCAstronomicalCoordinatesSystem system);

KPCAstronomicalCoordinatesComponents KPCMakeAstronomicalCoordinatesComponents(double v1,
																			  double v2,
																			  KPCCoordinatesUnits units,
																			  double epoch,
																			  KPCAstronomicalCoordinatesSystem system);

/// Precess the input equatorial components in the final epoch.
void KPCPrecessEquatorialCoordinatesComponents(KPCAstronomicalCoordinatesComponents *inComponents,
											   KPCAstronomicalCoordinatesComponents *outComponents,
											   double finalEpoch);

double KPCGalacticLongitudeFromEquatorialComponents(KPCCoordinatesComponents *base, double epoch);
double KPCGalacticLatitudeFromEquatorialComponents(KPCCoordinatesComponents *base, double epoch);

double KPCCelestialLongitudeFromEquatorialComponents(KPCCoordinatesComponents *base, double epoch);
double KPCCelestialLatitudeFromEquatorialComponents(KPCCoordinatesComponents *base, double epoch);

// Transform the input equatorial components into another coordinates system, without changing the epoch.
void KPCTransformEquatorialCoordinatesComponents(KPCAstronomicalCoordinatesComponents *inComponents,
												 KPCAstronomicalCoordinatesComponents *outComponents,
												 KPCAstronomicalCoordinatesSystem outputSystem);

void KPCEquatorialComponentsFromGalacticLongitudeLatitude(KPCCoordinatesComponents *components,
														  double l,
														  double b,
														  double epoch);

void KPCEquatorialComponentsFromCelestialLongitudeLatitude(KPCCoordinatesComponents *components,
														   double lambda,
														   double beta,
														   double epoch);

// Transform the input components into equatorial coordinates system, without changing the epoch.
void KPCTransformToEquatorialCoordinatesComponents(KPCAstronomicalCoordinatesComponents *inComponents,
												   KPCAstronomicalCoordinatesComponents *outComponents);

