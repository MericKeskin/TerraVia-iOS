//
//  String+.swift
//  TerraVia
//
//  Created by Meriç Keskin on 18.06.2025.
//

import Foundation

// MARK: - Validation

extension String {
    
    var isValidEmail: Bool {
        let emailRegex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        return count >= 8
    }
}
