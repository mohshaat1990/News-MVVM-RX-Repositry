//
//  PasswordViewModel.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 9/5/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct PasswordViewModel : FieldViewModel, SecureFieldViewModel {
    
    var value: BehaviorSubject<String> = BehaviorSubject(value: "")
    var errorValue: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    
    let title = "Password".localized()
    let errorMessage = "password must be more than eight characters".localized()
    
    var isSecureTextEntry: Bool = true
    
    func validate() -> Bool {
        // between 8 and 25 caracters
        guard validateSize(try! value.value(), size: (8,25)) else {
            errorValue.onNext(errorMessage)
            return false
        }
        errorValue.onNext(nil)
        return true
    }
}
