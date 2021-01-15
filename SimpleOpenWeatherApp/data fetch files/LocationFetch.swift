//
//  LoactionFetch.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//  Our Lady of Logic, ora pro nobis

import Foundation
import CoreLocation


class LocationFetch: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var locationError: LocationError?
    @Published var location: CLLocation?
    
    enum LocationError: Error, CustomStringConvertible {
        case unauthorised
        case failed(Error)
        
        var description: String {
            switch self {
            case .unauthorised:
                return "unauthorized to get location data"
            case .failed(let e):
                return "failed to get location: \(e.localizedDescription)"
            }
        }
    }
    
    
    let locationManager = CLLocationManager()
    
    weak var openFetch: OpenWeatherFetch?
    
    func startFetch(fetch: OpenWeatherFetch){
        if !CLLocationManager.locationServicesEnabled() {
            fatalError("fix this")
        }
        openFetch = fetch
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    func stopFetch(){
        locationManager.stopUpdatingLocation()
        if let location = location {
            let coordCalls = openFetch?.fetchWith(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            print("coord calls: \(String(describing: coordCalls))")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("authorization change")
        if manager.authorizationStatus != .authorizedWhenInUse {
            locationError = .unauthorised
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed location")
        if (error as? CLError)?.errorCode != CLError.Code.locationUnknown.rawValue {
            locationError = .failed(error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations updated")
        location = locations.last
        stopFetch()
    }
}

