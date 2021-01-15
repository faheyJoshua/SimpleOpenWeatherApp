//
//  Helper.swift
//  SimpleOpenWeatherApp
//
//  Created by Joshua Fahey on 1/14/21.
//  Our Lady of Logic, ora pro nobis

import Foundation

enum URLDecodableError: Error {
    case noData
    case invalidData
}

extension URL {
    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        guard let data = try? Data(contentsOf: self) else {
            throw URLDecodableError.noData
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            throw URLDecodableError.invalidData
        }
        
        return loaded
    }
}
