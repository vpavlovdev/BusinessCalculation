//
//  RegistrationViewModel.swift
//  BusinessCalculation
//
//  Created by VPDev on 15.04.2023.
//

import Foundation

class RegistrationViewModel {
    
}

extension RegistrationViewModel: RegistrationViewModelProtocol {
    func signInWithGoogle() {
        FirebaseAPIManager.shared.signInGoogle()
    }
    
    func registrationNewUser(name: String?, lastName: String?, email: String?, password: String?, endRegistration: @escaping () -> Void)
    {
        guard let myName = name,
              let myLastName = lastName,
              let myEmail = email,
              let myPassword = password else { return }
        let regUser = RegistrationUser(firstName: myName,
                                       lastName: myLastName,
                                       email: myEmail,
                                       password: myPassword)
        FirebaseAPIManager.shared.registrationNewUser(newUser: regUser)
        endRegistration()
    }
    
 
    
    
}
