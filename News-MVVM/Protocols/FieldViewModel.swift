//
//  VSFieldViewModel.swift
//  News-MVVM
//
//  Created by Mohamed Shaat on 9/5/19.
//  Copyright © 2019 shaat. All rights reserved.
//

import Foundation
import  RxSwift
import  RxCocoa

protocol FieldViewModel {
  
    var title: String { get}
    var errorMessage: String { get }
    
    // Observables
    var value: BehaviorSubject<String> { get set }
    var errorValue: BehaviorSubject<String?> { get}
    
    // Validation
    func validate() -> Bool
}

extension FieldViewModel {

    func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}
