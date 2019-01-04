//
//  UserModel.swift
//  RandomUser
//
//  Created by Keuahn Lumanog on 1/3/19.
//  Copyright © 2019 Keuahn Lumanog. All rights reserved.
//

import Foundation

class User {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var pictureUrl: String = ""

    init(firstName: String, lastName: String, email: String, pictureUrl: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.pictureUrl = pictureUrl
    }

}
