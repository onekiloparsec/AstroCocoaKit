//
//  KPCCoordinatesComponents.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//

#import <Foundation/Foundation.h>

typedef struct KPCSexagesimalComponents {
    int degrees; // always > 0
    int minutes; // always > 0
	double seconds; // always > 0
	int sign;
} KPCSexagesimalComponents;

// NEVER change order of enums, as this will break existing (keyed) coordinates archives.

typedef NS_ENUM(NSUInteger, KPCCoordinatesUnits) {
	KPCCoordinatesUnitsUndefined,
	KPCCoordinatesUnitsHoursAndDegrees, // For RA and Dec.
	KPCCoordinatesUnitsDefault,
	KPCCoordinatesUnitsDegrees = KPCCoordinatesUnitsDefault,
	KPCCoordinatesUnitsRadians,
	KPCCoordinatesUnitsHours
};

typedef struct KPCCoordinatesComponents {
    double theta;
    double phi;
    KPCCoordinatesUnits units;
} KPCCoordinatesComponents;

KPCCoordinatesComponents KPCMakeCoordinatesComponents(id input);
NSValue *KPCMakeComponentsValue(KPCCoordinatesComponents components);

KPCSexagesimalComponents KPCMakeSexagesimalComponents(int d, int m, double s);
KPCSexagesimalComponents KPCMakeSexagesimalComponentsFromValue(double value);
KPCSexagesimalComponents KPCMakeSexagesimalComponentsFromArray(NSArray *values);

double KPCSexagesimalComponentsValue(KPCSexagesimalComponents components);

NSArray *KPCSexagesimalCoordinatesSymbols(KPCCoordinatesUnits units);
NSString *KPCDecimalCoordinatesSymbol(KPCCoordinatesUnits units);

void KPCTransformCoordinatesComponentsUnits(KPCCoordinatesComponents *inComponents,
											KPCCoordinatesComponents *outComponents,
											KPCCoordinatesUnits outputUnits);

