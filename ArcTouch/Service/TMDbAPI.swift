//
//  TMDbAPI.swift
//  ArcTouch
//
//  Created by Fernando Gallo on 29/08/19.
//  Copyright © 2019 Fernando Gallo. All rights reserved.
//

import Foundation
import Moya

public enum TMDbAPI {
    case movies(page: Int)
}

extension TMDbAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: Constants.TMDbAPI.endpoint)!
    }
    
    public var path: String {
        switch self {
        case .movies:
            return "/movie/upcoming"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .movies:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .movies(let page):
            return .requestParameters(parameters: [Constants.Parameters.apiKey: Constants.TMDbAPI.apiKey,
                                                   Constants.Parameters.page: page],
                                      encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
}

let TMDbProvider = MoyaProvider<TMDbAPI>(plugins:
    [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}
