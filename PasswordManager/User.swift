//
//  User.swift
//  PasswordManager
//
//  Created by Nathan Leach on 10/5/23.
//

import Foundation
import SwiftData
import JWTDecode

struct User {
    let id: String
    let name: String
    let email: String
    let emailVerified: String
    let updatedAt: String
}

extension User {
    
    static var empty: Self {
        return User(
            id: "",
            name: "",
            email: "",
            emailVerified: "",
            updatedAt: ""
        )
    }
    
    static func from(_ idToken: String) -> Self {
        guard
            let jwt = try? decode(jwt: idToken),
            let id = jwt.subject,
            let name = jwt.claim(name: "name").string,
            let email = jwt.claim(name: "email").string,
            let emailVerified = jwt.claim(name: "email_verified").boolean,
            let updatedAt = jwt.claim(name: "updated_at").string
        else {
            return .empty
        }
        return User(
            id: id,
            name: name,
            email: email,
            emailVerified: String(describing: emailVerified),
            updatedAt: updatedAt
        )
    }
    
}
