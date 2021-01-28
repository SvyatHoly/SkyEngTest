//
//  String+Capitlization.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Foundation

extension String {
    
    var alphabetic: String {
        let alphabeticChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return self.filter {alphabeticChars.contains($0) }
    }
}
