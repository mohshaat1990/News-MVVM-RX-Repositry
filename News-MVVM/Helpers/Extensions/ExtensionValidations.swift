//
//  ExtensionValidations.swift
//  Zumra
//
//  Created by Mohamed Shaat on 3/19/18.
//  Copyright © 2018 10degree. All rights reserved.
//

import Foundation
extension String  {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var isEmail: Bool {
       
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isSaudiNumber:Bool{
    let saudiNumberRegEx = "(05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})"
    let saudiNumberTest  = NSPredicate(format:"SELF MATCHES %@", saudiNumberRegEx)
    return saudiNumberTest.evaluate(with: self)
    }

    var isPasswordMoreThaneightCharacters:Bool {
        
        if self.count > 5 {
            return true
        }else {
            return false
        }
    }
    var isPasswordMoreThanFourCharacters:Bool {
        if self.count > 4 {
            return true
        }else {
            return false
        }
    }
    
}
