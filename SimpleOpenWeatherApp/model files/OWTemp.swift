//
//  OWTemp.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//  Our Lady of Logic, ora pro nobis

import Foundation


struct OWTemp: Codable {
    let temp: Double
    
    #if DEBUG
    static let testTemp = OWTemp(temp: 32.4)
    #endif
}
