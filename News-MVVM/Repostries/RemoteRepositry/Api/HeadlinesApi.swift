//
//  HeadlinesAPI.swift
//  news
//
//  Created by mac2 on 9/4/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import Foundation
import Moya


struct HeadlinesParamters {
    static let country = "country"
    static let page = "page"
    static let pageSize = "pageSize"
    static let apiKey = "apiKey"
}
 enum HeadlinesApi {
    case getTopHeadlines(newsRequest: NewsRequest)
}
extension HeadlinesApi: TargetType {
    public var baseURL: URL { return URL(string: APPURL.BaseURL)! }
    
    public var path: String {
        switch self {
        case .getTopHeadlines(_):
            return APPURL.Paths.NewsUrl
        }
    }
    
    public var method: Moya.Method {
            return .get
    }
    
    public var task: Task {
        switch self {
        case .getTopHeadlines(let newsRequest):
            return .requestParameters(parameters: [HeadlinesParamters.country: newsRequest.countryCode,HeadlinesParamters.page: newsRequest.page,HeadlinesParamters.pageSize: newsRequest.pageSize, HeadlinesParamters.apiKey: Key.Headers.NewsApiKey], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data { return Data() }  // We just need to return something here to fully implement the protocol
    
    public var headers: [String: String]? {
        return [Key.Headers.KEY_ContentType: Key.Headers.KEY_ContentTypeValue]
    }
}

