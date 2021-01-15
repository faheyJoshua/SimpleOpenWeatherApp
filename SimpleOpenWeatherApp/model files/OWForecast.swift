//
//  OWForecast.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//  Our Lady of Logic, ora pro nobis

import Foundation


struct OWForecast: Codable {
    let list: [OWReport]
    
    #if DEBUG
    static let testForecast = OWForecast(list: [OWReport.testReport, OWReport.testReport, OWReport.testReport])
    #endif
}
