//
//  OWWeather.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//  Our Lady of Logic, ora pro nobis

import Foundation
import UIKit

struct OWWeather: Codable {
    
    private var urlPath: URL {
        return URL(string:"https://openweathermap.org/img/wn/\(icon)@2x.png")!
    }
    
    let id: Int
    let main: String
    let description: String
    let icon: String
    
//    lazy var image: UIImage? = {
//        guard let data = try? Data(contentsOf: urlPath) else {return nil}
//        return UIImage(data: data)
//    }()
    
    var imageURL: URL {
        return urlPath
    }
    var image: UIImage? {
        if let data = try? Data(contentsOf: urlPath) {
            return UIImage(data: data)
        }
        return nil
    }
    
    #if DEBUG
    static let testWeather = OWWeather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
    #endif
}
