//
//  CurrentWeatherView.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    let report: OWReport
    
    var body: some View {
        VStack(alignment: .trailing){
            Text("Fetched at \(report.timeString)")
            HStack{
                if let weather = report.weather.first {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.2))
                        if let image = weather.image {
                            Image(uiImage: image)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 100, height: 100)
                    VStack(alignment: .trailing){
                        Text(weather.description)
                        Text("\(report.tempString)ºF")
                            .bold()
                    }
                } else {
                    Text("\(report.tempString)ºF")
                        .bold()
                }
            }
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(report: OWReport.testReport)
    }
}
