//
//  NetworkResponse.swift
//  Covid-19
//
//  Created by Tareq Mohammad on 1/9/22.
//

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
