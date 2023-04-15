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
import FirebaseFirestoreSwift
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
    //MARK: Reg newUser
    func registrationNewUser(newUser: RegisterUser) {
        DispatchQueue.main.async {
            Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { (result, error) in
                guard error == nil  else { print("this error "); return }
                let db = self.configureFB()
                db.collection("users").document("\(newUser.email.lowercased())").setData(
                    ["firstName" : newUser.firstName,
                     "lastName" : newUser.lastName,
                     "uid" : result!.user.uid])
                { (error) in
                    guard error == nil else { return } //Change label
                }
                print("Registration compleate")
            }
        }
    }
    //MARK: SignIn with Email
    func signInUser(email: String, password: String, completion: @escaping (_ errorText: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                //Handle AuthErrors
                if let castError = error as NSError?,
                   let codeError = AuthErrorCode.Code(rawValue: castError.code) {
                    switch codeError {
                    case .wrongPassword,
                         .invalidEmail: completion("Неверная пара email/пароль")
                    case .userNotFound: completion("Пользователь не найден")
                    case .networkError: completion("Отсутсвует интернет соединение")
                    default: return
                    }
                }
                return }
            
            UserDefaults.standard.set(true, forKey: "Loged")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc: MainScreenTabBarContoller())
        }
    }
    //MARK: SignIn with Google
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
    //MARK: Delete user
    func  deleteUser(completion: @escaping (Error?) -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        user.delete { error in
            guard error == nil else { completion(error); return }
            completion(nil)
        }
    }
    //MARK: Get user
    func getUser(completion: @escaping (AuthUserModel)-> Void) {
        guard let user = Auth.auth().currentUser,
              let email = user.email else { return }
        let db = configureFB()
        db.collection("users").document("\(email)").getDocument { (document, error) in
            guard error == nil else { return }
            let currentUser = try? document?.data(as: AuthUserModel.self)
            completion(currentUser ?? AuthUserModel())
        }
        
    }
}

