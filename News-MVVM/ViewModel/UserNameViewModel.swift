//
//  UserNameViewModel.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 9/5/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct UserNameViewModel: FieldViewModel {
    
    var value: BehaviorSubject<String> = BehaviorSubject(value: "")
    var errorValue: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    
    let title = "userName".localized()
    let errorMessage = "user name must be more than eight characters".localized()
    
    
    func validate() -> Bool {
        guard validateSize(try! value.value(), size: (8,25)) else {
            errorValue.onNext(errorMessage)
            return false
        }
        errorValue.onNext(nil)
        return true
    }
}
