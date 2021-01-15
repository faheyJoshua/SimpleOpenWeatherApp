//
//  ForecastWeatherView.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//

import SwiftUI

struct ForecastWeatherView: View {
    
    let forecast: OWForecast
    
    var body: some View {
        List {
            ForEach(forecast.list, id: \.dt){report in
                ForecastWeatherCell(report: report)
            }
        }
    }
}

struct ForecastWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastWeatherView(forecast: OWForecast.testForecast)
    }
}
