//
//  ContentView.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/13/21.
//  Our Lady of Logic, ora pro nobis

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var fetch = OpenWeatherFetch()
    @ObservedObject var locationFetch = LocationFetch()
    
    @State var gettingLocation = false
    @State var zipValue: String = ""
    
    var body: some View {
        NavigationView{
            if !gettingLocation {
                GetLocationView(fetch: fetch, locationFetch: locationFetch, gettingLocation: $gettingLocation, zipValue: $zipValue)
            } else {
                VStack{
                    if let report = fetch.weatherReport {
                        Spacer()
                        HStack{
                            Spacer()
                            CurrentWeatherView(report: report)
                            Spacer()
                        }
                        Spacer()
                    } else {
                        if let error = locationFetch.locationError {
                            Text("Error getting location \(error.description)")
                        }
                        Spacer()
                        ProgressView()
                    }
                    Spacer()
                    HStack{
                        Button("Reset Location"){
                            zipValue = ""
                            gettingLocation = false
                            locationFetch.stopFetch()
                        }
                        .padding(5)
                        Spacer()
                        if let forecast = fetch.forecastReport{
                            NavigationLink(destination: ForecastWeatherView(forecast: forecast)) {
                                Text("Forecast >")
                                    .padding(5)
                            }
                        }
                    }
                }
            }
        }
        .alert(item: $fetch.fetchError) { (error) -> Alert in
            Alert(title: Text("Unable to get weather"),
                  message: Text(error.description),
                  dismissButton: .default(Text("Got it!")){
                    gettingLocation = false
                  })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
