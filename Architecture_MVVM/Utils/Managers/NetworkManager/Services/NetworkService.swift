//
//  ProgressIndicatorManager.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import UIKit

struct VerbosePlugin: PluginType {
    let verbose: Bool
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        #if DEBUG
        if let body = request.httpBody,
            let str = String(data: body, encoding: .utf8) {
            print("request to send: \(str))")
        }
        
        if let url = request.url?.absoluteString {
            print("requested URL: \(url)")
        }
        #endif
        return request
    }
}

final class NetworkService {

    static let shared: NetworkService = NetworkService()

    private let reachabilityManager = NetworkReachabilityManager()
    
    //    [NetworkLoggerPlugin(configuration: .init(formatter: .init(), output: { (target, array) in
    //        print(array)
    //    }, logOptions: .verbose))]
    
    var weatherApiProvider = MoyaProvider<WeatherApiProvider>(session: DefaultAlamofireManager.sharedManager, plugins: [VerbosePlugin(verbose: true)])

    private init() {}

    func callService<T: Codable, TT:TargetType, P: MoyaProvider<TT>>(_ provider:P, type:TT, success: @escaping ((T) -> Void), failure: @escaping ((AppError) -> Void)){
        if (reachabilityManager?.isReachable)! {
            provider.request(type) { (result) in
                switch result {
                case let .success(response):
                    do {
                        switch response.statusCode {
                        case 200...299:
                            let modelObj = try JSONDecoder().decode(T.self, from: response.data)
                            success(modelObj)
                        default:
                            let error = try JSONDecoder().decode(AppError.self, from: response.data)
                            failure(error)
                        }
                    } catch {
                        failure(AppError(cod: "\((error as NSError).code)", message: error.localizedDescription))
                    }
                case let .failure(error):
                    failure(AppError(cod: "\((error as NSError).code)", message: error.localizedDescription))
                }
            }
        }
    }
    
    func internetIsWorking() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
}
/// Custom alamofire manager class that is used to customise the alamofile session manager.
class DefaultAlamofireManager: Alamofire.Session {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 60 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 60 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
