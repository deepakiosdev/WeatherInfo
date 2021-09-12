//
//  NetworkingProtocols.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkRequestProtocol {
    var scheme: String { get }
    var host: String { get }
    var requestMethod: RequestMethod { get }
    var endPoint: String { get }
    var parameters: [URLQueryItem] { get }
    var body: Data? { get }
}
