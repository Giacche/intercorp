//
//  User.swift
//  Intercorp-Test
//
//  Created by Lucas Giacche on 15/08/2021.
//

import Foundation

struct User{
    var userFirstName: String
    var userLastName: String
    var userAge: String
    var userDateBirth: String
    
    init(userFirstName: String, userLastName: String, userAge: String, userDateBirth: String) {
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userAge = userAge
        self.userDateBirth = userDateBirth
    }
    
}
