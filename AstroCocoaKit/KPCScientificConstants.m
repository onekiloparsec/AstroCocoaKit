//
//  KPCScientificConstants.m
//
//  Created by onekiloparsec on 13/3/10.
//  https://github.com/onekiloparsec/AstroCocoaKit
//  Released under licence GPL v2
//
//  AA = Jean Meeus' Astronomical Algorithms text book.
//

#import "KPCScientificConstants.h"

const double RAD2DEG		= 57.295779513082322865;			// = 180/pi
const double RAD2HOUR		= 3.8197186342054880726;			// = 180/pi * 24/360
const double DEG2RAD		= 0.017453292519943295474;			// = pi/180
const double DEG2HOUR		= 0.06666666666666666666666;		// = 24/360
const double HOUR2RAD		= 0.26179938779914940783;			// = 360/24 * pi/180
const double ARCSEC2RAD		= 4.8481368110953598427e-06;		// = pi/(180*3600)
const double ARCSEC2DEG		= 0.00027777777777777777777;		// = 1/3600

const double YEAR2SEC		= 31556952.0;	// AVERAGE_GREGORIAN_YEAR * 86400;
const double MONTH2SEC		= 2635200.0;	// 30.5 * 86400 || IMPRECISE!!!
const double WEEK2SEC       = 604800.0;		// 7*86400;
const double DAY2SEC		= 86400.0;
const double DAY2MIN		= 1440.0;
const double DAY2HOUR		= 24.0;
const double HOUR2SEC		= 3600.0;
const double HOUR2MIN		= 60.0;
const double MIN2SEC		= 60.0;
const double HALFDAY2HOUR	= 12.0;

const double GREENWICH_LONGITUDE = 0.0;
const double GREENWICH_LATITUDE  = 51.4788;
const double GREENWICH_ALTITUDE  = 0.0;

const double STANDARD_JULIAN_EPOCH		= 2000.0;
const double J2000						= 2451545.0;
const double MODIFIED_JULIAN_DAY_ZERO   = 2400000.5;
const double JULIAN_YEAR				= 365.25;		// See p.133 of AA.
const double BESSELIAN_YEAR				= 365.2421988;	// See p.133 of AA.
const double JULIAN_DAY_B1950_0			= 2433282.4235;	// See p.133 of AA.

const double SIDEREAL_OVER_SOLAR_RATE	= 1.0027379093;	// Sidereal / solar rate.
const double AVERAGE_JULIAN_YEAR		= 365.25;		// See Observer's handbook (1999 - RAS of Canada).
const double AVERAGE_GREGORIAN_YEAR		= 365.2425;		//
const double AVERAGE_SIDEREAL_YEAR		= 365.256363;	// Fixed star to fixed star.
const double AVERAGE_ANOMALISTIC_YEAR	= 365.259635;	// Perihelion to perihelion.
const double AVERAGE_TROPICAL_YEAR		= 365.242190;	// Equinox to equinox.
const double AVERAGE_ECLIPSE_YEAR		= 346.620075;	// Lunar mode to lunar mode.

const double ECLIPTIC_OBLIQUITY_J2000_0 = 23.4392911;	// In degrees, see p.92 of AA.
const double ECLIPTIC_OBLIQUITY_B1950_0 = 23.4457889;	// In degrees, see p.92 of AA.

const double GALACTIC_NORTH_POLE_ALPHA_B1950_0 = 192.25;	// Fixed by convention by the IAU
const double GALACTIC_NORTH_POLE_DELTA_B1950_0 = 27.4;		// Fixed by convention by the IAU
const double GALACTIC_NORTH_POLE_ALPHA_J2000_0 = 192.855;	// Fixed by convention by the IAU
const double GALACTIC_NORTH_POLE_DELTA_J2000_0 = 27.13;		// Fixed by convention by the IAU

/*
 http://neo.jpl.nasa.gov/glossary/au.html
 Definition: An Astronomical Unit is approximately the mean distance between the Earth and the Sun. It is a derived 
 constant and used to indicate distances within the solar system. Its formal definition is the radius of an unperturbed 
 circular orbit a massless body would revolve about the sun in 2*(pi)/k days (i.e., 365.2568983.... days), where k is 
 defined as the Gaussian constant exactly equal to 0.01720209895. Since an AU is based on radius of a circular orbit, 
 one AU is actually slightly less than the average distance between the Earth and the Sun (approximately 150 million 
 km or 93 million miles).
*/
const double UA2KM = 149597870.7;			// http://www.iau.org/static/resolutions/IAU2012_English.pdf (previously: .691)
const double PC2UA = 206264.80624548031;	// = 1.0/tan(1./3600.0*M_PI/180.);
const double PC2LY = 3.263797724738089;		// = pc*ua/SPEED_OF_LIGHT_KMS/(ONE_DAY_INSECONDS*365.0)

const double HUBBLE_CONSTANT = 72.0; // (km/s)/Mpc.

//http://physics.nist.gov/cuu/index.html
const double PLANCK_CONSTANT = 6.62606957e-34;		// Joule * seconds;
const double BOLTZMANN_CONSTANT = 1.3806488e-23;	// Joule/Kelvin

const double SPEED_OF_LIGHT		= 299792458.0;
const double SPEED_OF_LIGHT_KMS	= 299792.458;

// http://nssdc.gsfc.nasa.gov/planetary/factsheet/
// http://solarscience.msfc.nasa.gov

const double SOLAR_MASS   = 1.98855e30;		// kg;
const double JUPITER_MASS = 1.8990e27;		// kg;
const double NEPTUNE_MASS = 1.0243e26;		// kg;
const double EARTH_MASS   = 5.9736e24;		// kg;

// EQUATORIAL RADII. See http://nssdc.gsfc.nasa.gov/planetary/factsheet/jupiterfact.html
const double SOLAR_RADIUS_KM	= 695990.0;
const double JUPITER_RADIUS_KM	= 71492.0;
const double NEPTUNE_RADIUS_KM	= 24764.0;
const double EARTH_RADIUS_KM	= 6378.137;

const double EARTH_RADIUS_FLATTENING_FACTOR	= 1./298.257;	// See p82 of AA.

const double ABSOLUTE_ZERO_TEMPERATURE_CELSIUS = -273.15;


const double NOT_A_SCIENTIFIC_NUMBER		= -999999999999999.0; // A double NaN that is not NaN for scientific computations.
NSString *const UNDEFINED_STRING_PROPERTY	= @"UNDEFINED_STRING_PROPERTY";
