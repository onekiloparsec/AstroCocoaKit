//
//  STLSphericalCoordinates.h
//  iObserve
//
//  Created by Soft Tenebras Lux on 16/1/10.
//  Copyright 2010 Soft Tenebras Lux. All rights reserved.
//

// STLSphericalCoordinates is an IMMUTABLE object.

#import "KPCCoordinatesComponents.h"

@interface KPCSphericalCoordinates : NSObject <NSCoding, NSCopying> {
@private
	double _theta;
	double _phi;
	KPCCoordinatesUnits _units;
}

@property(nonatomic, assign) KPCCoordinatesUnits displayedUnits;

+ (instancetype)emptyCoordinates;
- (id)initWithTheta:(double)t phi:(double)p units:(KPCCoordinatesUnits)u;

- (BOOL)areEmpty;

- (KPCCoordinatesComponents)components;

- (double)theta;
- (double)phi;
- (KPCCoordinatesUnits)units;

- (double)greatCircleAngularDistanceToCoordinates:(KPCSphericalCoordinates *)otherCoordinates; // In degrees

+ (NSString *)shortPositionAngleString:(double)value;
+ (NSString *)positionAngleString:(double)value;
+ (NSString *)separationAngleString:(double)value;

@end
