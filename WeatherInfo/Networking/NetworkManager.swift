//
//  NetworkManager.swift
//  WeatherInfo
//
//  Created by Dipak Pandey on 12/09/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(using urlRequest: URLRequest) -> Observable<T>
}

struct NetworkManager: NetworkManagerProtocol {
    
    func fetch<T: Decodable>(using urlRequest: URLRequest) -> Observable<T> {
        return Observable.just(urlRequest)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: urlRequest)
            }.map { response, data -> T in

                if 200 ..< 300 ~= response.statusCode {
                    return try JSONDecoder().decode(T.self, from: data)
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }

            }.asObservable()
    }
}
