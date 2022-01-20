//
//  StatisticsModel.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import Foundation

// MARK: - StatisticsModel
struct StatisticsModel: Codable {
    let dates: [String: DateValue]?
    let metadata: Metadata?
    let total: Country?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case dates, metadata, total
        case updatedAt = "updated_at"
    }
}

// MARK: - DateValue
struct DateValue: Codable {
    let countries: Countries?
    let info: Info?
}

// MARK: - Countries
struct Countries: Codable {
    let country: Country?
    enum CodingKeys: String, CodingKey {
        case country

    }
}

// MARK: - Total
struct Country: Codable {
    let date, id: String?
    let links: [Link]?
    let name, nameEs, nameIt: String?
    let source: String?
    let todayConfirmed, todayDeaths, todayNewConfirmed, todayNewDeaths: Int
    let todayNewOpenCases, todayNewRecovered, todayOpenCases, todayRecovered: Int
    let todayVsYesterdayConfirmed, todayVsYesterdayDeaths, todayVsYesterdayOpenCases, todayVsYesterdayRecovered: Double?
    let yesterdayConfirmed, yesterdayDeaths, yesterdayOpenCases, yesterdayRecovered: Int?
    let rid: String?

    enum CodingKeys: String, CodingKey {
        case date, id, links, name
        case nameEs = "name_es"
        case nameIt = "name_it"
        case source
        case todayConfirmed = "today_confirmed"
        case todayDeaths = "today_deaths"
        case todayNewConfirmed = "today_new_confirmed"
        case todayNewDeaths = "today_new_deaths"
        case todayNewOpenCases = "today_new_open_cases"
        case todayNewRecovered = "today_new_recovered"
        case todayOpenCases = "today_open_cases"
        case todayRecovered = "today_recovered"
        case todayVsYesterdayConfirmed = "today_vs_yesterday_confirmed"
        case todayVsYesterdayDeaths = "today_vs_yesterday_deaths"
        case todayVsYesterdayOpenCases = "today_vs_yesterday_open_cases"
        case todayVsYesterdayRecovered = "today_vs_yesterday_recovered"
        case yesterdayConfirmed = "yesterday_confirmed"
        case yesterdayDeaths = "yesterday_deaths"
        case yesterdayOpenCases = "yesterday_open_cases"
        case yesterdayRecovered = "yesterday_recovered"
        case rid
    }
}

// MARK: - Link
struct Link: Codable {
    let href, rel, type: String?
}

// MARK: - Info
struct Info: Codable {
    let date, dateGeneration, yesterday: String?

    enum CodingKeys: String, CodingKey {
        case date
        case dateGeneration = "date_generation"
        case yesterday
    }
}

// MARK: - Metadata
struct Metadata: Codable {
    let by: String?
    let url: [String]?
}
