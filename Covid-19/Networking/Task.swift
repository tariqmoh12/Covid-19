//
//  Task.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

typealias Parameters = [String: Any]

enum TaskS {
    case requestPlain
    case requestParameters(Parameters)
    case uploadMultipart
}
