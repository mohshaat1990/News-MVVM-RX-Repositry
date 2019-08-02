//
//  KeyConstants.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 7/27/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import Foundation

struct Key {
    
    static let DeviceType = "iOS"
    
    struct UserDefaults {
        static let k_App_Running_FirstTime = "userRunningAppFirstTime"
    }
    
    struct  NewsDefaults {
          static let defaultCountryCode = "US"
          static let PageSize = 10
    }
    
    struct Headers {
        static let Authorization = "Authorization"
        static let ContentType = "Content-Type"
        static let NewsApiKey = "e991749d19b64815a80e53b694a3df89"
        static let KEY_ApiName = "X-Api-Key"
        static let KEY_ApiValue = "55axvd80c2jxp31y"
        static let KEY_LANG = "Accept-Language"
        static let KEY_Authorization = "Authorization"
        static let KEY_ContentType = "Content-type"
        static let KEY_ContentTypeValue = "application/json"
        static let KEY_Encoding = "Accept-Encoding"
        static let KEY_EncodingValue = "application/json"
    }
    
    struct ErrorMessage{
        static let listNotFound = "ERROR_LIST_NOT_FOUND"
        static let validationError = "ERROR_VALIDATION"
    }
}
