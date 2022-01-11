//
//  CountriesModel.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import Foundation

// MARK: - CountriesModelElement
struct CountriesModelElement: Codable {
    let name: String?
    let alpha2Code, alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let subregion: String?
    let population: Int?
    let latlng: [Double]?
    let demonym: String?
    let area: Double?
    let nativeName, numericCode: String?
    let flags: FlagsElement?
    let currencies: [Currency]?
    let flag: String?
    let cioc: String?
    let independent: Bool?
    let gini: Double?
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}

// MARK: - Flags
struct FlagsElement: Codable {
    let svg: String?
    let png: String?
}


