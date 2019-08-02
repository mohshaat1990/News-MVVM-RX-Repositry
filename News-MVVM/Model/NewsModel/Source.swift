//
//  Source.swift
//
//  Created by Mohamed shaat  on 9/4/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

 class Source: Mappable {
    
    

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let name = "name"
  }

  // MARK: Properties
  public var id: String?
  public var name: String?

    required init?(map: Map){}
    
    
    func mapping(map: Map) {
        id <- map[SerializationKeys.id]
        name <- map[SerializationKeys.name]
    }

}
