//
//  AuthViewModelProtocol.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.04.2023.
//

import Foundation

protocol AuthViewModelProtocol {
    var statusText: Dynamic<String> { get }
    func signIn(email: String, password: String, endLoading: @escaping () -> Void)
    func signInWithGoogle()
}
