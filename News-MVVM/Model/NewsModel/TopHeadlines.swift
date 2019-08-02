//
//  TopHeadlines.swift
//
//  Created by  Mohamed shaat on 9/4/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class TopHeadlines: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let status = "status"
        static let totalResults = "totalResults"
        static let articles = "articles"
    }
    
    // MARK: Properties
    public var status: String?
    public var totalResults: Int?
    public var articles: [Article]?
    
    required init?(map: Map){}
    
    
    func mapping(map: Map) {
        articles <- map[SerializationKeys.articles]
        status   <- map[SerializationKeys.status]
        totalResults   <- map[SerializationKeys.totalResults]
    }
    
}
