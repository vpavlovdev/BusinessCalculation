//
//  RegistrationViewModelProtocol.swift
//  BusinessCalculation
//
//  Created by VPDev on 15.04.2023.
//

import Foundation

protocol RegistrationViewModelProtocol {
    func registrationNewUser(name: String?, lastName: String?, email: String?, password: String?)
    func signInWithGoogle()
}
