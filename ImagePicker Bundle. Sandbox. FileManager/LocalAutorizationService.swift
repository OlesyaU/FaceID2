//
//  LocalAutorizationService.swift
//  ImagePicker Bundle. Sandbox. FileManager
//
//  Created by Олеся on 05.06.2023.
//

import Foundation
import LocalAuthentication

final class LocalAutorizationService {
    private let laContext = LAContext()
    private var error: NSError?

    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void){
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Идентифицируйте себя"
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                authorizationFinished(true)
                if success {
                    print("Успешная авторизация")
                }
            }

        } else {
            authorizationFinished(false)
            print(error?.localizedDescription)
            print("Face/Touch ID не найден")
        }
    }
}
