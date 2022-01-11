//
//  Apis.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

import Foundation
import Moya
 
typealias headers = [String : String]?

    enum Apis {
        case tracking(name : String,fromDate : String,toDate:String)
        case articles(country : String)
        case countries
       }

extension Apis: TargetType {
   
    var baseURL: URL
    {
        switch self {
        case .tracking:
            guard let url = URL(string: URLs.trackingURL) else { fatalError("baseURL could not be configured.")}
            return url
        case .articles:
            guard let url = URL(string: URLs.articlesURL) else { fatalError("baseURL could not be configured.")}
            return url
        case .countries:
            guard let url = URL(string: URLs.countriesURL) else { fatalError("baseURL could not be configured.")}
            return url
        }
    }
    var path: String {
        switch self {
        case .tracking(let name, _,_) :
            return "\(name)"
        case .articles :
            return "top-headlines"
        default :
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .tracking:
            return .get
        case .articles:
            return .get
        case .countries:
            return .get
        }
    }
    
    
    var task: Task {
        switch self {
        case .tracking(_,let fromDate,let toDate):
            return .requestParameters(parameters: ["date_from" :fromDate ,"date_to":toDate], encoding: URLEncoding.default)
        case .articles(let country):
            return .requestParameters(parameters: ["country" :country ,"category":"health", "apiKey" : Constants.ApiKey], encoding: URLEncoding.default)
        default :
            return .requestPlain

       
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers:  headers{
        switch self {
        case .tracking:
        return ["Accept" : "application/json"]
        case .articles:
        return ["Accept" : "application/json"]
        case .countries:
        return ["Accept" : "application/json"]
        
        }
        
    }
    
    
    func stubbedResponse(_ filename:String) -> Data! {
        @objc class TestClass : NSObject {}
        let bundel = Bundle(for: TestClass.self)
        let path = bundel.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
    
}
