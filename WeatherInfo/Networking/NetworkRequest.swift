//
//  NetworkRequest.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation

enum NetworkRequest {
    //List of api requests
    case weatherForecast(_ location: Location)
}

//MARK: Full NetworkRequestDataProtocol requiremnts(Cunstruct request parmaters)
extension NetworkRequest: NetworkRequestProtocol {
    
    var scheme: String {
        return Constants.Api.scheme
    }
    
    var host: String {
        return Constants.Api.host
    }
    
    var requestMethod: RequestMethod {
        return .get
    }
    
    var endPoint: String {
        switch self {
        case .weatherForecast:
            return "/data/2.5/forecast"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .weatherForecast(let location):
            
            return [
                URLQueryItem(name: "mode", value: "json"),
                URLQueryItem(name:"units", value:"metric"),
                URLQueryItem(name:"lat", value:location.latitude),
                URLQueryItem(name:"lon", value:location.longitude),
                URLQueryItem(name:"appid", value: Constants.Api.accessKey)]
            
        }
    }
    
    var body: Data? {
        nil
    }
}


//Create and configure URLRequest
extension NetworkRequest {
    
    func urlRequest() throws -> URLRequest {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = endPoint
        components.queryItems = parameters
        
        guard let url = components.url else {
            throw  WAError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod.rawValue
        
        if let body = body {
            request.httpBody = body
        }
        print("Request fields: \(String(describing: request.allHTTPHeaderFields))")

        return request
        
    }
}
