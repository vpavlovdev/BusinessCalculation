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
import GoogleSignIn
import GoogleSignInSwift

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
        DispatchQueue.main.async {
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
    }
    
    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (resutl, error) in
            guard error == nil else { return }
            print("We auth in app")
        }
    }
    func signInGoogle() {
        DispatchQueue.main.async {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first,
                  let rootViewController = window
                    .rootViewController else { print("There is no root ViewController"); return }
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                guard error == nil else { return }
                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString else { return }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                Auth.auth().signIn(with: credential) { result, error in
                    
                }
            }

        }
    }
}

