//
//  GetLocationView.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//

import SwiftUI

struct GetLocationView: View {
    
    @ObservedObject var fetch: OpenWeatherFetch
    @ObservedObject var locationFetch: LocationFetch
    @Binding var gettingLocation: Bool
    @Binding var zipValue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Get weather")
                .fontWeight(.black)
                .padding(.bottom)
            Button("Use Current Location"){
                locationFetch.startFetch(fetch: fetch)
                gettingLocation = true
            }
            Divider()
                .frame(maxWidth:200)
            TextField("Zip code", text: $zipValue)
                .frame(maxWidth: 200, minHeight: 40)
                .background(Color.blue.opacity(0.2))
            Button("Use Zip Code"){
                let zipCalls = fetch.fetchWithZip(zip: zipValue)
                print("zip calls: \(zipCalls)")
                gettingLocation = true
            }
            Spacer()
        }
    }
}

struct GetLocationView_Previews: PreviewProvider {
    static var previews: some View {
        GetLocationView(fetch: OpenWeatherFetch(), locationFetch: LocationFetch(), gettingLocation: .constant(true), zipValue: .constant(""))
    }
}
