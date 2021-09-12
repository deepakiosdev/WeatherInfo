//
//  WAError.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation

enum WAError: Error {
    
    //Web Service errors
    case invalidURL
    case requestParameterError
    case noData
    case networkRequestFailed
    
    //Json Parsing errors
    case jsonParsingFailed
    
    //Location errors
    case unableToFindLocation
    
    //Unknown Error
    case unknown(String)
    
    
    var errorDescription: String {
        
        switch self {
            
        case .invalidURL:
            return "Invalid url"
            
        case .requestParameterError:
            return "Problem with api request parameter"
            
        case .noData:
            return "Record not available"
            
        case .networkRequestFailed:
            return "Api failed"
            
        case .jsonParsingFailed:
            return "Json Parsing Failed"
            
        case .unableToFindLocation:
            return "Unable To Find Location"
            
        case .unknown (let errorDesc):
            return errorDesc.isEmpty ? "Unknown error" : errorDesc
            
        }
    }
}
