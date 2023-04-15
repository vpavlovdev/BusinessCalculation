//
//  AuthViewModel.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.04.2023.
//

import Foundation

class AuthViewModel {
    private var text = Dynamic(value: "")
}

extension AuthViewModel: AuthViewModelProtocol {
    var statusText: Dynamic<String> {
        get {
            text
        }
    }
    
    func signIn(email: String, password: String) {
        //Auth in app
        FirebaseAPIManager.shared.signInUser(email: email, password: password) { [weak self] errorText in
            self?.text.value = errorText
        }
        //Get current user
        
    }
    
    func signInWithGoogle() {
        FirebaseAPIManager.shared.signInGoogle()
    }
    
    
}
