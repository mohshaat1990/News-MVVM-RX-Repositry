//
//  Articles.swift
//
//  Created by  Mohamed shaat on 9/4/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

class Article: BaseObject {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let publishedAt = "publishedAt"
    static let descriptionValue = "description"
    static let title = "title"
    static let urlToImage = "urlToImage"
    static let author = "author"
    static let url = "url"
  }

  // MARK: Properties
  @objc dynamic  var publishedAt: String = ""
  @objc dynamic  var descriptionValue: String = ""
  @objc dynamic  var title: String = ""
  @objc dynamic  var urlToImage: String = ""
  @objc dynamic  var author: String = ""
  @objc dynamic  var url: String = ""

   
    
    override func mapping(map: Map) {
        urlToImage <- map[SerializationKeys.urlToImage]
        descriptionValue <- map[SerializationKeys.descriptionValue]
        title <- map[SerializationKeys.title]
        author <- map[SerializationKeys.author]
    }

}
