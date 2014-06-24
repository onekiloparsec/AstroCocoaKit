//
//  STLTwilightSet.h
//  iObserve
//
//  Created by onekiloparsec on 21/7/13.
//  Copyright (c) 2013 onekiloparsec. All rights reserved.
//

#import "KPCTwilightConstants.h"
#import "KPCTerrestrialCoordinates.h"

@interface KPCTwilightSet : NSObject 

+ (KPCTwilightSet *)twilightSetForNoonDate:(NSDate *)date coordinates:(KPCTerrestrialCoordinates *)coords;

- (NSDate *)noonDate;
- (KPCTerrestrialCoordinates *)inputCoordinates;

- (void)updateWithNoonDate:(NSDate *)date;
- (void)updateWithCoordinates:(KPCTerrestrialCoordinates *)coords;
- (void)updateWithNoonDate:(NSDate *)date coordinates:(KPCTerrestrialCoordinates *)coords;

- (double)sunNightMinimumAltitude;
- (double)sunDayMaximumAltitude;

- (BOOL)hasNight;
- (NSUInteger)twilightDepthsCount;

- (double)eveningTwilightJulianDayForMode:(KPCTwilightMode)mode;
- (double)morningTwilightJulianDayForMode:(KPCTwilightMode)mode;

//- (STLSmartColor *)skyColorForDate:(NSDate *)date;

@end
