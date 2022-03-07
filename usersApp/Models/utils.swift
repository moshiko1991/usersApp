//
//  utils.swift
//  usersApp
//
//  Created by moshiko elkalay on 26/02/2022.
//

import Foundation

extension String {
    //Email validtion test
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
