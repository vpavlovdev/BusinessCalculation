//
//  AuthViewModel.swift
//  BusinessCalculation
//
//  Created by VPDev on 10.04.2023.
//

import Foundation

class AuthViewModel {
    
}

extension AuthViewModel: AuthViewModelProtocol {
    func signIn(email: String, password: String) {
        //Auth in app
        FirebaseAPIManager.shared.signInUser(email: email, password: password)
        
        //Get current user
        
    }
    
    func signInWithGoogle() {
        FirebaseAPIManager.shared.signInGoogle()
    }
    
    
}
