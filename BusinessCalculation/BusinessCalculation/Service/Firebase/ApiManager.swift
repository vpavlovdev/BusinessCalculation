//
//  ApiManager.swift
//  BusinessCalculation
//
//  Created by VPDev on 18.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabaseSwift

class FirebaseAPIManager {
    static let shared = FirebaseAPIManager()
    
    private init() {}
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func registrationNewUser(newUser: User) {
        Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { (result, error) in
            guard error == nil  else { print("this error "); return }
            let db = self.configureFB()
            db.collection("users").addDocument(
                data: ["firstName" : newUser.firstName,
                       "lastName" : newUser.lastName,
                       "uid" : result!.user.uid])
            { (error) in
                guard error == nil else { return } //Change label
            }
            print("Registration compleate")
        }
    }
    
    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (resutl, error) in
            guard error == nil else { return }
            print("We auth in app")
        }
    }
}

