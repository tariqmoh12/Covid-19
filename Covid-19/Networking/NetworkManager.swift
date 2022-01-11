//
//  NetworkManager.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import Foundation
import Moya
import Alamofire


struct NetworkManager {
    static let shared =  NetworkManager()
    let provider = MoyaProvider<Apis>(plugins: [NetworkLoggerPlugin()])
}
