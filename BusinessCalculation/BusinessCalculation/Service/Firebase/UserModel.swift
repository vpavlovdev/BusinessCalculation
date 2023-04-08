//
//  UserModel.swift
//  BusinessCalculation
//
//  Created by VPDev on 18.03.2023.
//

import Foundation
import FirebaseFirestoreSwift


struct RegisterUser: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
}

struct AuthUser: Codable {
    var firstName: String?
    var lastName: String?
    var uid: String?
}
