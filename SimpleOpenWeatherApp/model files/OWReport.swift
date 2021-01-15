//
//  OWReport.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/13/21.
//  Our Lady of Logic, ora pro nobis

import Foundation

struct OWReport: Codable {
    
    static let dateTimeFormatter: DateFormatter = {
        let format = DateFormatter()
        format.timeStyle = .short
        
        return format
    }()
    static let dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "E, MMM d"
        
        return format
    }()
    
    static let tempFormatter: NumberFormatter = {
        let format = NumberFormatter()
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 1
        
        return format
    }()
    
    let dt: Date
//    let time: Int
    let main: OWTemp
    let weather: [OWWeather]
    
//    var date: Date {
//        return Date(timeIntervalSince1970: TimeInterval(time))
//    }
    
    var tempString: String {
        return OWReport.tempFormatter.string(from: NSNumber(value:main.temp)) ?? "invalid number"
    }
    
    var dateString: String {
        return OWReport.dateFormatter.string(from: dt)
    }
    
    var timeString: String {
        return OWReport.dateTimeFormatter.string(from: dt)
    }
    
    #if DEBUG
    static let testReport = OWReport(dt: Date(), main: OWTemp.testTemp, weather: [OWWeather.testWeather])
    #endif
}
