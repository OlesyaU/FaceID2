//
//  LoginManager.swift
//  ImagePicker Bundle. Sandbox. FileManager
//
//  Created by Олеся on 24.03.2023.
//

import UIKit


final class LoginManager {
    
//    var defaultManager = LoginManager()
    
    static func showLoginAleart(in viewController: UIViewController, with text: String){
        let aleart = UIAlertController(title: "ОШИБКА", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Хорошо", style: .cancel)
        aleart.addAction(action)
        viewController.present(aleart, animated: true)
    }
}
