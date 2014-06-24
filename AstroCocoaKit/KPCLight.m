//
//  KPCLight.m
//  iObserve
//
//  Created by Cédric Foellmi on 9/10/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import "KPCLight.h"
#import "KPCScientificConstants.h"

// See also http://www.vikdhillon.staff.shef.ac.uk/teaching/phy217/instruments/phy217_inst_mags.html

double frequencyFromWavelength(double mu)
{
    return SPEED_OF_LIGHT / (mu / 1e6);
}

double blackBodySpectralRadianceBnu(double nu, double K) // Jy steradian^-1
{
    return 1e26 * 2*PLANCK_CONSTANT*pow(nu, 3.0)/pow(SPEED_OF_LIGHT, 2.0) / (exp(PLANCK_CONSTANT*nu/(BOLTZMANN_CONSTANT*K)) - 1.);
}

// Return units: units of Bnu1
double blackBodySpectralRadianceWithReferenceValueBnu(double nu1, double Bnu1, double nu2, double K, double rvKms)
{
    if (rvKms) {
        nu2 *= (1.0 + rvKms/SPEED_OF_LIGHT_KMS);
    }
	return Bnu1 * pow(nu2 / nu1, 3.0) * (exp(PLANCK_CONSTANT*nu1/(BOLTZMANN_CONSTANT*K)) - 1) / (exp(PLANCK_CONSTANT*nu2/(BOLTZMANN_CONSTANT*K)) - 1);
}

double magnitudeForFlux(double F, double F0)
{
    return -2.5 * log10(F/F0);
}

double magnitudeForFluxMagnitudeZero(double F, double mag0)
{
    return -2.5 * log10(F) - mag0;
}

double fluxForMagnitude(double mag, double F0)
{
    return F0 * pow(10.0, mag/-2.5);
}


// Ref: http://www.stsci.edu/hst/nicmos/tools/conversion_help.html
// Oke, J.B. & Gunn, J. 1983, ApJ, 266, 713
double ABMagnitude(double Jy)
{
	return -2.5 * log10(fluxInErgcm2sHz(Jy)) - 48.57;
}

double fluxInWm2Hz(double Jy)
{
	return Jy * 1e-26;
}

double fluxInWm2mu(double Jy, double mu)
{
	return fluxInWm2Hz(Jy) * SPEED_OF_LIGHT * 1e2 / pow(mu, 2.0); // Express c in mu/s.
}

double fluxInErgcm2sHz(double Jy)
{
	return Jy * 1e-23;
}

double fluxInErgcm2sA(double Jy, double mu)
{
	return fluxInErgcm2sHz(Jy) * SPEED_OF_LIGHT * 1e2 / pow(mu, 2.0); // Express c in A/s, and mu in A.
}

// N_nu = F_nu / E = F_nu / (h nu) = F_nu / (lambda/hc)
double fluxInPhotcm2sHz(double Jy, double mu)
{
	return fluxInWm2Hz(Jy) / 1e4 * mu*1e-6 / SPEED_OF_LIGHT / PLANCK_CONSTANT;
}

double fluxInPhotcm2sA(double Jy, double mu)
{
	return fluxInPhotcm2sHz(Jy, mu) * SPEED_OF_LIGHT * 1e2 / pow(mu, 2.0); // Express c in mu/s.
}

// -- Inverse relationships

double fluxInJyFromABMagnitude(double mag)
{
	return 1e23 * pow(10.0, (mag + 48.57) / (-2.5));
}

double fluxInJyFromWm2Hz(double f)
{
	return f / 1e-26;
}

double fluxInJyFromWm2mu(double f, double mu)
{
	return f * 1e26 * pow(mu, 2.0) / SPEED_OF_LIGHT / 1e2;
}

//double fluxInJyFromWcm2mu(double f)
//{
//	return f / 3e-16;
//}

double fluxInJyFromErgcm2sHz(double f)
{
	return f * 1e23;
}

double fluxInJyFromErgcm2sA(double f, double mu)
{
	return f * 1e23 / SPEED_OF_LIGHT / 1e10 * pow(mu*1e4, 2.0);
}

double fluxInJyFromPhotcm2sHz(double f, double mu)
{
	return f * 1e26 * 1e4 / (mu*1e-6) * SPEED_OF_LIGHT * PLANCK_CONSTANT;
}

double fluxInJyFromPhotcm2sA(double f, double mu)
{
	return f * (mu*1e4) / 1.50918896e3;
}


