//
//  KPCAstroCocoaKit.h
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//
//
// --- Conventions ---
// Throughout the code, 'AA' refers to Jean Meeus' reference textbook, 'Astronomical Algorithm', 2nd edition.
// http://www.amazon.com/Astronomical-Algorithms-Jean-Meeus/dp/0943396611
//
// Physical Convention: The longitude values are positive to the East. This is the only physical convention
// that is not following Astronomical Algorithms (for purely historical reason).
//
// Documentation convention: Use Xcode5 new triple / to quickly document a method, function etc.
// Editing convention: Watch your spaces, newlines and character consistency. The editing width is set at 120 chars.
//

#import "KPCScientificConstants.h"

#import "KPCCoordinatesComponents.h"
#import "KPCAstronomicalCoordinatesComponents.h"

#import "KPCSphericalCoordinates.h"
#import "KPCTerrestrialCoordinates.h"
#import "KPCAstronomicalCoordinates.h"
#import "KPCAstronomicalCoordinates+Labels.h"

#import "KPCTimes.h"
#import "KPCSun.h"
#import "KPCSky.h"
#import "KPCLight.h"
#import "KPCMoon.h"
#import "KPCEarth.h"

#import "KPCTwilights.h"
#import "KPCTwilightConstants.h"
#import "KPCTwilightSet.h"

#import "NSDate+KPCTimes.h"
#import "NSNumber+KPCValueStrings.h"
