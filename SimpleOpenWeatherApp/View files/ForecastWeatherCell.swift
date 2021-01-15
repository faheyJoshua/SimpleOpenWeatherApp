//
//  ForecastWeatherCell.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//

import SwiftUI

struct ForecastWeatherCell: View {
    
    let report: OWReport
    
    @ObservedObject var imageFetcher = ImageFetch()
    
    var body: some View {
        HStack{
            if let weather = report.weather.first {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.2))
                    if let image = imageFetcher.image {
                        Image(uiImage: image)
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 100, height: 100)
                
                VStack(alignment: .leading){
                    Text(weather.description)
                    Text("\(report.tempString)ºF")
                        .bold()
                }
            } else {
                Text("\(report.tempString)ºF")
                    .bold()
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("\(report.dateString)")
                Text("\(report.timeString)")
            }
        }
        .frame(minHeight: 40)
    }
    
    init(report: OWReport) {
        self.report = report
        if let weather = report.weather.first {
            imageFetcher.loadImage(with: weather.imageURL)
        }
    }
}

struct ForecastWeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        ForecastWeatherCell(report: OWReport.testReport)
    }
}
