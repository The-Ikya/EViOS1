//
//  RegisteredUser.swift
//  EViOS1
//
//  Created by Mavrik on 07/07/2022.
//

import UIKit

class RegisteredUser {
    let login: String
    let password: String
    let newsletter: Bool
    
    init(login: String, password: String, newsletter: Bool) {
        self.login = login
        self.password = password
        self.newsletter = newsletter
    }
}
