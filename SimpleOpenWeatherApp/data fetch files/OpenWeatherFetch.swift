//
//  OpenWeatherFetch.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/13/21.
//  Our Lady of Logic, ora pro nobis

import Foundation


class OpenWeatherFetch: ObservableObject {
    private static let baseurl = "https://api.openweathermap.org/data/2.5/"
    private static let appID = "156419e36923b495d64fb35be9e6d577"
    
    private static let currentWeatherCall = "weather?units=imperial"
    private static let fiveDayForecastCall = "forecast?units=imperial"
    
    private static func getId() -> String {
        return "&appID=\(OpenWeatherFetch.appID)"
    }
    
    private static func getArgs(lat: Double, lon: Double) -> String{
        return "&lat=\(lat)&lon=\(lon)"
    }
    private static func getArgs(zip: String) -> String{
        return "&zip=\(zip),us"
    }
    
    @Published var weatherReport: OWReport?
    @Published var forecastReport: OWForecast?
    
    @Published var fetchError: FetchError?
    
    
    class FetchError: Identifiable {
        let id: UUID
        
        let description: String
        
        init(description: String) {
            self.description = description
            self.id = UUID()
        }
    }
    
    func fetchWithZip(zip: String) -> (current:String, forecast:String) {
        let weatherPath = "\(OpenWeatherFetch.baseurl)\(OpenWeatherFetch.currentWeatherCall)\(OpenWeatherFetch.getArgs(zip: zip))"
        let forecastPath = "\(OpenWeatherFetch.baseurl)\(OpenWeatherFetch.fiveDayForecastCall)\(OpenWeatherFetch.getArgs(zip: zip))"
        guard let fullWeatherURL = URL(string: "\(weatherPath)\(OpenWeatherFetch.getId())"),
              let fullForecastURL = URL(string: "\(forecastPath)\(OpenWeatherFetch.getId())") else {
            
            fetchError = FetchError(description: "Badly formatted url")
            
            return (weatherPath,forecastPath)
        }
        
        DispatchQueue.global().async{
            DispatchQueue.main.async {
                let report = try? fullWeatherURL.decode(OWReport.self)
                if report == nil {
                    do {
                        let error = try fullWeatherURL.decode(OWError.self)
                        if error.message.contains("not found") {
                            self.fetchError = FetchError(description: "No such zip code")
                        } else {
                            self.fetchError = FetchError(description: error.message)
                        }
                    } catch {
                        self.fetchError = FetchError(description: "No such zip code")
                    }
                } else {
                    self.weatherReport = report
                    print("got the weather")
                    DispatchQueue.global().async{
                        DispatchQueue.main.async {
                            do {
                                self.forecastReport = try fullForecastURL.decode(OWForecast.self)
                                print("got the forecast")
                            }catch {
                                self.fetchError = FetchError(description: "unexpected response from url")
                            }
                        }
                    }
                }
            }
        }
        
        
        return (weatherPath, forecastPath)
    }
    
    func fetchWith(lat:Double, lon:Double) -> (current:String, forecast:String) {
        let weatherPath = "\(OpenWeatherFetch.baseurl)\(OpenWeatherFetch.currentWeatherCall)\(OpenWeatherFetch.getArgs(lat: lat, lon: lon))"
        let forecastPath = "\(OpenWeatherFetch.baseurl)\(OpenWeatherFetch.fiveDayForecastCall)\(OpenWeatherFetch.getArgs(lat: lat, lon: lon))"
        guard let fullWeatherURL = URL(string: "\(weatherPath)\(OpenWeatherFetch.getId())"),
              let fullForecastURL = URL(string: "\(forecastPath)\(OpenWeatherFetch.getId())") else {
            
            fetchError = FetchError(description: "Badly formatted url")
            
            return (weatherPath,forecastPath)
        }
        
        DispatchQueue.global().async{
            DispatchQueue.main.async {
                let report = try? fullWeatherURL.decode(OWReport.self)
                if report == nil {
                    do {
                        let error = try fullWeatherURL.decode(OWError.self)
                        if error.message.contains("not found") {
                            self.fetchError = FetchError(description: "No such geo coordinates")
                        } else {
                            self.fetchError = FetchError(description: error.message)
                        }
                    } catch {
                        self.fetchError = FetchError(description: "No such geo coordinates")
                    }
                } else {
                    self.weatherReport = report
                    print("got the weather")
                    DispatchQueue.global().async{
                        DispatchQueue.main.async {
                            do {
                                self.forecastReport = try fullForecastURL.decode(OWForecast.self)
                                print("got the forecast")
                            } catch {
                                self.fetchError = FetchError(description: "unexpected response from url")
                            }
                        }
                    }
                }
            }
        }
        
        return (weatherPath, forecastPath)
    }
}
