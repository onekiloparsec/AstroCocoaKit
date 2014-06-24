//
//  KPCLight.h
//  iObserve
//
//  Created by Cédric Foellmi on 9/10/12.
//  Copyright (c) 2012 Soft Tenebras Lux. All rights reserved.
//

#import <Foundation/Foundation.h>

double frequencyFromWavelength(double mu);

double blackBodySpectralRadianceBnu(double nu, double K); // Jy steradian^-1
double blackBodySpectralRadianceWithReferenceValueBnu(double nu1, double Bnu1, double nu2, double K, double rvKms); // In units of Bnu1

double magnitudeForFlux(double F, double F0);
double magnitudeForFluxMagnitudeZero(double F, double mag0);
double fluxForMagnitude(double mag, double F0);

double ABMagnitude(double Jy);
double fluxInWm2Hz(double Jy);
double fluxInWm2mu(double Jy, double mu);
double fluxInErgcm2sHz(double Jy);
double fluxInErgcm2sA(double Jy, double mu);
double fluxInPhotcm2sHz(double Jy, double mu);
double fluxInPhotcm2sA(double Jy, double mu);

double fluxInJyFromABMagnitude(double mag);
double fluxInJyFromWm2Hz(double f);
double fluxInJyFromWm2mu(double f, double mu);
//double fluxInJyFromWcm2mu(double f);
double fluxInJyFromErgcm2sHz(double f);
double fluxInJyFromErgcm2sA(double f, double mu);
double fluxInJyFromPhotcm2sHz(double f, double mu);
double fluxInJyFromPhotcm2sA(double f, double mu);

