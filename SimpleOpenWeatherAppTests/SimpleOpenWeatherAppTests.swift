//
//  SimpleOpenWeatherAppTests.swift
//  SimpleOpenWeatherAppTests
//
//  Created by Joshua Fahey on 1/13/21.
//

import XCTest
@testable import SimpleOpenWeatherApp

class SimpleOpenWeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testZipURL(){
        let zip = "49937"
        let fetch = OpenWeatherFetch()
        
        let paths = fetch.fetchWithZip(zip: zip)
        
        XCTAssertTrue(paths.current.contains("https://api.openweathermap.org/data/2.5/weather?units=imperial&zip=49937,us"))
        XCTAssertTrue(paths.forecast.contains("https://api.openweathermap.org/data/2.5/forecast?units=imperial&zip=49937,us"))
        
        let url1 = URL(string: paths.current)
        let url2 = URL(string: paths.forecast)
        
        XCTAssertNotNil(url1)
        XCTAssertNotNil(url2)
    }

    func testCoordURL(){
        let fetch = OpenWeatherFetch()
        
        let paths = fetch.fetchWith(lat: 23.5, lon: -45.7)
        
        XCTAssertTrue(paths.current.contains("https://api.openweathermap.org/data/2.5/weather?units=imperial&lat=\(23.5)&lon=\(-45.7)"))
        XCTAssertTrue(paths.forecast.contains("https://api.openweathermap.org/data/2.5/forecast?units=imperial&lat=\(23.5)&lon=\(-45.7)"))
        
        let url1 = URL(string: paths.current)
        let url2 = URL(string: paths.forecast)
        
        XCTAssertNotNil(url1)
        XCTAssertNotNil(url2)
    }
    
    func testOWError(){
        let stringCodable = """
        {"cod":"404","message":"city not found"}
        """
        let codable = stringCodable.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let _ = try decoder.decode(OWError.self, from: codable)
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testOWReport(){
        let stringCodable = """
        {"coord":{"lon":-88.558,"lat":47.1158},"weather":[{"id":701,"main":"Mist","description":"mist","icon":"50d"}],"base":"stations","main":{"temp":35.15,"feels_like":25.7,"temp_min":34,"temp_max":36,"pressure":1003,"humidity":87},"visibility":6437,"wind":{"speed":10.36,"deg":80,"gust":20.71},"clouds":{"all":90},"dt":1610724024,"sys":{"type":1,"id":3661,"country":"US","sunrise":1610717742,"sunset":1610749884},"timezone":-18000,"id":0,"name":"Houghton","cod":200}
        """
        let codable = stringCodable.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let report = try decoder.decode(OWReport.self, from: codable)
            
            XCTAssertTrue(true)
            
            let img = report.weather.first?.image
            XCTAssertNotNil(img)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func testOWForecast(){
        let stringCodable = """
        {"cod":"200","message":0,"cnt":40,"list":[{"dt":1610733600,"main":{"temp":35.01,"feels_like":25.09,"temp_min":34.86,"temp_max":35.01,"pressure":1004,"sea_level":1004,"grnd_level":977,"humidity":92,"temp_kf":0.08},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":95},"wind":{"speed":11.52,"deg":77},"visibility":2201,"pop":0.3,"rain":{"3h":0.22},"sys":{"pod":"d"},"dt_txt":"2021-01-15 18:00:00"},{"dt":1610744400,"main":{"temp":34.52,"feels_like":24.66,"temp_min":34.34,"temp_max":34.52,"pressure":1006,"sea_level":1006,"grnd_level":977,"humidity":95,"temp_kf":0.1},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":98},"wind":{"speed":11.5,"deg":60},"visibility":44,"pop":0.34,"snow":{"3h":0.33},"sys":{"pod":"d"},"dt_txt":"2021-01-15 21:00:00"},{"dt":1610755200,"main":{"temp":34,"feels_like":24.3,"temp_min":33.93,"temp_max":34,"pressure":1009,"sea_level":1009,"grnd_level":979,"humidity":96,"temp_kf":0.04},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":99},"wind":{"speed":11.14,"deg":52},"visibility":9056,"pop":0.35,"snow":{"3h":0.43},"sys":{"pod":"n"},"dt_txt":"2021-01-16 00:00:00"},{"dt":1610766000,"main":{"temp":33.04,"feels_like":23.85,"temp_min":33.03,"temp_max":33.04,"pressure":1009,"sea_level":1009,"grnd_level":979,"humidity":98,"temp_kf":0.01},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":10.13,"deg":28},"visibility":50,"pop":0.5,"snow":{"3h":0.27},"sys":{"pod":"n"},"dt_txt":"2021-01-16 03:00:00"},{"dt":1610776800,"main":{"temp":32.61,"feels_like":22.8,"temp_min":32.61,"temp_max":32.61,"pressure":1008,"sea_level":1008,"grnd_level":978,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":11.03,"deg":21},"visibility":42,"pop":0.64,"snow":{"3h":0.73},"sys":{"pod":"n"},"dt_txt":"2021-01-16 06:00:00"},{"dt":1610787600,"main":{"temp":32.09,"feels_like":23.04,"temp_min":32.09,"temp_max":32.09,"pressure":1007,"sea_level":1007,"grnd_level":977,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":99},"wind":{"speed":9.57,"deg":30},"visibility":8427,"pop":0.56,"snow":{"3h":0.44},"sys":{"pod":"n"},"dt_txt":"2021-01-16 09:00:00"},{"dt":1610798400,"main":{"temp":30.69,"feels_like":21.29,"temp_min":30.69,"temp_max":30.69,"pressure":1008,"sea_level":1008,"grnd_level":978,"humidity":98,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":98},"wind":{"speed":9.89,"deg":15},"visibility":1003,"pop":0.54,"snow":{"3h":0.22},"sys":{"pod":"n"},"dt_txt":"2021-01-16 12:00:00"},{"dt":1610809200,"main":{"temp":30.25,"feels_like":20.46,"temp_min":30.25,"temp_max":30.25,"pressure":1008,"sea_level":1008,"grnd_level":978,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":99},"wind":{"speed":10.42,"deg":15},"visibility":10000,"pop":0.37,"snow":{"3h":0.18},"sys":{"pod":"d"},"dt_txt":"2021-01-16 15:00:00"},{"dt":1610820000,"main":{"temp":31.32,"feels_like":21.7,"temp_min":31.32,"temp_max":31.32,"pressure":1007,"sea_level":1007,"grnd_level":977,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":99},"wind":{"speed":10.36,"deg":13},"visibility":1375,"pop":0.53,"snow":{"3h":0.23},"sys":{"pod":"d"},"dt_txt":"2021-01-16 18:00:00"},{"dt":1610830800,"main":{"temp":29.97,"feels_like":18.97,"temp_min":29.97,"temp_max":29.97,"pressure":1006,"sea_level":1006,"grnd_level":976,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":12.48,"deg":7},"visibility":8479,"pop":0.76,"snow":{"3h":0.43},"sys":{"pod":"d"},"dt_txt":"2021-01-16 21:00:00"},{"dt":1610841600,"main":{"temp":27.54,"feels_like":17.6,"temp_min":27.54,"temp_max":27.54,"pressure":1006,"sea_level":1006,"grnd_level":976,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":10.07,"deg":357},"visibility":954,"pop":0.61,"snow":{"3h":0.21},"sys":{"pod":"n"},"dt_txt":"2021-01-17 00:00:00"},{"dt":1610852400,"main":{"temp":26.85,"feels_like":17.83,"temp_min":26.85,"temp_max":26.85,"pressure":1006,"sea_level":1006,"grnd_level":976,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":8.28,"deg":349},"visibility":3007,"pop":0.65,"snow":{"3h":0.3},"sys":{"pod":"n"},"dt_txt":"2021-01-17 03:00:00"},{"dt":1610863200,"main":{"temp":26.85,"feels_like":18.16,"temp_min":26.85,"temp_max":26.85,"pressure":1006,"sea_level":1006,"grnd_level":975,"humidity":98,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":7.76,"deg":352},"visibility":345,"pop":0.51,"snow":{"3h":0.39},"sys":{"pod":"n"},"dt_txt":"2021-01-17 06:00:00"},{"dt":1610874000,"main":{"temp":26.06,"feels_like":16.57,"temp_min":26.06,"temp_max":26.06,"pressure":1006,"sea_level":1006,"grnd_level":976,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":8.95,"deg":355},"visibility":751,"pop":0.33,"snow":{"3h":0.36},"sys":{"pod":"n"},"dt_txt":"2021-01-17 09:00:00"},{"dt":1610884800,"main":{"temp":24.98,"feels_like":15.08,"temp_min":24.98,"temp_max":24.98,"pressure":1006,"sea_level":1006,"grnd_level":976,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":9.48,"deg":360},"visibility":849,"pop":0.32,"snow":{"3h":0.38},"sys":{"pod":"n"},"dt_txt":"2021-01-17 12:00:00"},{"dt":1610895600,"main":{"temp":25.05,"feels_like":15.93,"temp_min":25.05,"temp_max":25.05,"pressure":1007,"sea_level":1007,"grnd_level":977,"humidity":96,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":8.05,"deg":13},"visibility":2719,"pop":0.32,"snow":{"3h":0.27},"sys":{"pod":"d"},"dt_txt":"2021-01-17 15:00:00"},{"dt":1610906400,"main":{"temp":25.86,"feels_like":17.26,"temp_min":25.86,"temp_max":25.86,"pressure":1008,"sea_level":1008,"grnd_level":977,"humidity":95,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":7.25,"deg":10},"visibility":2892,"pop":0.35,"snow":{"3h":0.16},"sys":{"pod":"d"},"dt_txt":"2021-01-17 18:00:00"},{"dt":1610917200,"main":{"temp":25.43,"feels_like":16.48,"temp_min":25.43,"temp_max":25.43,"pressure":1007,"sea_level":1007,"grnd_level":977,"humidity":95,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":7.76,"deg":356},"visibility":4206,"pop":0.23,"snow":{"3h":0.17},"sys":{"pod":"d"},"dt_txt":"2021-01-17 21:00:00"},{"dt":1610928000,"main":{"temp":24.53,"feels_like":16.18,"temp_min":24.53,"temp_max":24.53,"pressure":1009,"sea_level":1009,"grnd_level":978,"humidity":96,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":6.6,"deg":354},"visibility":3572,"pop":0.23,"snow":{"3h":0.13},"sys":{"pod":"n"},"dt_txt":"2021-01-18 00:00:00"},{"dt":1610938800,"main":{"temp":24.55,"feels_like":17.94,"temp_min":24.55,"temp_max":24.55,"pressure":1008,"sea_level":1008,"grnd_level":978,"humidity":96,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":3.51,"deg":13},"visibility":6480,"pop":0.03,"sys":{"pod":"n"},"dt_txt":"2021-01-18 03:00:00"},{"dt":1610949600,"main":{"temp":24.24,"feels_like":18.39,"temp_min":24.24,"temp_max":24.24,"pressure":1009,"sea_level":1009,"grnd_level":978,"humidity":95,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":2.06,"deg":335},"visibility":10000,"pop":0.01,"sys":{"pod":"n"},"dt_txt":"2021-01-18 06:00:00"},{"dt":1610960400,"main":{"temp":23.83,"feels_like":17.28,"temp_min":23.83,"temp_max":23.83,"pressure":1009,"sea_level":1009,"grnd_level":978,"humidity":96,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":96},"wind":{"speed":3.27,"deg":338},"visibility":10000,"pop":0.06,"sys":{"pod":"n"},"dt_txt":"2021-01-18 09:00:00"},{"dt":1610971200,"main":{"temp":24.37,"feels_like":17.76,"temp_min":24.37,"temp_max":24.37,"pressure":1009,"sea_level":1009,"grnd_level":979,"humidity":96,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":90},"wind":{"speed":3.47,"deg":349},"visibility":5674,"pop":0.2,"snow":{"3h":0.11},"sys":{"pod":"n"},"dt_txt":"2021-01-18 12:00:00"},{"dt":1610982000,"main":{"temp":25.41,"feels_like":20.57,"temp_min":25.41,"temp_max":25.41,"pressure":1010,"sea_level":1010,"grnd_level":980,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":0.58,"deg":14},"visibility":372,"pop":0.37,"snow":{"3h":0.22},"sys":{"pod":"d"},"dt_txt":"2021-01-18 15:00:00"},{"dt":1610992800,"main":{"temp":27.16,"feels_like":20.91,"temp_min":27.16,"temp_max":27.16,"pressure":1011,"sea_level":1011,"grnd_level":981,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":3.44,"deg":199},"visibility":588,"pop":0.48,"snow":{"3h":0.51},"sys":{"pod":"d"},"dt_txt":"2021-01-18 18:00:00"},{"dt":1611003600,"main":{"temp":27.43,"feels_like":21.2,"temp_min":27.43,"temp_max":27.43,"pressure":1012,"sea_level":1012,"grnd_level":981,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":3.44,"deg":168},"visibility":567,"pop":0.74,"snow":{"3h":0.54},"sys":{"pod":"d"},"dt_txt":"2021-01-18 21:00:00"},{"dt":1611014400,"main":{"temp":25.21,"feels_like":14.9,"temp_min":25.21,"temp_max":25.21,"pressure":1014,"sea_level":1014,"grnd_level":984,"humidity":98,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":10.31,"deg":39},"visibility":201,"pop":0.7,"snow":{"3h":1.27},"sys":{"pod":"n"},"dt_txt":"2021-01-19 00:00:00"},{"dt":1611025200,"main":{"temp":20.73,"feels_like":6.78,"temp_min":20.73,"temp_max":20.73,"pressure":1016,"sea_level":1016,"grnd_level":985,"humidity":97,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":15.9,"deg":5},"visibility":223,"pop":0.94,"snow":{"3h":1.26},"sys":{"pod":"n"},"dt_txt":"2021-01-19 03:00:00"},{"dt":1611036000,"main":{"temp":18.05,"feels_like":5.63,"temp_min":18.05,"temp_max":18.05,"pressure":1018,"sea_level":1018,"grnd_level":986,"humidity":96,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":12.71,"deg":1},"visibility":856,"pop":0.92,"snow":{"3h":0.42},"sys":{"pod":"n"},"dt_txt":"2021-01-19 06:00:00"},{"dt":1611046800,"main":{"temp":15.33,"feels_like":3.24,"temp_min":15.33,"temp_max":15.33,"pressure":1019,"sea_level":1019,"grnd_level":988,"humidity":95,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":11.74,"deg":352},"visibility":729,"pop":0.58,"snow":{"3h":0.36},"sys":{"pod":"n"},"dt_txt":"2021-01-19 09:00:00"},{"dt":1611057600,"main":{"temp":13.71,"feels_like":1.45,"temp_min":13.71,"temp_max":13.71,"pressure":1020,"sea_level":1020,"grnd_level":989,"humidity":95,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":11.81,"deg":354},"visibility":639,"pop":0.68,"snow":{"3h":0.39},"sys":{"pod":"n"},"dt_txt":"2021-01-19 12:00:00"},{"dt":1611068400,"main":{"temp":13.33,"feels_like":1.96,"temp_min":13.33,"temp_max":13.33,"pressure":1022,"sea_level":1022,"grnd_level":991,"humidity":94,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":10.18,"deg":353},"visibility":744,"pop":0.68,"snow":{"3h":0.35},"sys":{"pod":"d"},"dt_txt":"2021-01-19 15:00:00"},{"dt":1611079200,"main":{"temp":14.18,"feels_like":3.52,"temp_min":14.18,"temp_max":14.18,"pressure":1022,"sea_level":1022,"grnd_level":991,"humidity":93,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":8.95,"deg":345},"visibility":1444,"pop":0.55,"snow":{"3h":0.26},"sys":{"pod":"d"},"dt_txt":"2021-01-19 18:00:00"},{"dt":1611090000,"main":{"temp":13.78,"feels_like":3.56,"temp_min":13.78,"temp_max":13.78,"pressure":1021,"sea_level":1021,"grnd_level":990,"humidity":93,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":100},"wind":{"speed":8.14,"deg":328},"visibility":1660,"pop":0.29,"snow":{"3h":0.2},"sys":{"pod":"d"},"dt_txt":"2021-01-19 21:00:00"},{"dt":1611100800,"main":{"temp":13.5,"feels_like":3.45,"temp_min":13.5,"temp_max":13.5,"pressure":1022,"sea_level":1022,"grnd_level":990,"humidity":93,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":7.81,"deg":312},"visibility":4322,"pop":0.29,"snow":{"3h":0.16},"sys":{"pod":"n"},"dt_txt":"2021-01-20 00:00:00"},{"dt":1611111600,"main":{"temp":13.78,"feels_like":4.69,"temp_min":13.78,"temp_max":13.78,"pressure":1022,"sea_level":1022,"grnd_level":991,"humidity":94,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":6.15,"deg":308},"visibility":1020,"pop":0.35,"snow":{"3h":0.19},"sys":{"pod":"n"},"dt_txt":"2021-01-20 03:00:00"},{"dt":1611122400,"main":{"temp":13.37,"feels_like":5.67,"temp_min":13.37,"temp_max":13.37,"pressure":1021,"sea_level":1021,"grnd_level":990,"humidity":94,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":100},"wind":{"speed":3.65,"deg":282},"visibility":1841,"pop":0.35,"snow":{"3h":0.34},"sys":{"pod":"n"},"dt_txt":"2021-01-20 06:00:00"},{"dt":1611133200,"main":{"temp":10.96,"feels_like":2.26,"temp_min":10.96,"temp_max":10.96,"pressure":1020,"sea_level":1020,"grnd_level":988,"humidity":94,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"clouds":{"all":99},"wind":{"speed":5.12,"deg":228},"visibility":4356,"pop":0.33,"snow":{"3h":0.23},"sys":{"pod":"n"},"dt_txt":"2021-01-20 09:00:00"},{"dt":1611144000,"main":{"temp":10.6,"feels_like":0.25,"temp_min":10.6,"temp_max":10.6,"pressure":1019,"sea_level":1019,"grnd_level":987,"humidity":93,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":99},"wind":{"speed":8.01,"deg":190},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2021-01-20 12:00:00"},{"dt":1611154800,"main":{"temp":13.6,"feels_like":1.47,"temp_min":13.6,"temp_max":13.6,"pressure":1015,"sea_level":1015,"grnd_level":984,"humidity":92,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":100},"wind":{"speed":11.48,"deg":168},"visibility":10000,"pop":0.02,"sys":{"pod":"d"},"dt_txt":"2021-01-20 15:00:00"}],"city":{"id":0,"name":"Houghton","coord":{"lat":47.1158,"lon":-88.558},"country":"US","population":0,"timezone":-18000,"sunrise":1610717742,"sunset":1610749884}}
        """
        let codable = stringCodable.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let _ = try decoder.decode(OWForecast.self, from: codable)
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
}
