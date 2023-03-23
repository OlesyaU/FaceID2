//
//  LoginController.swift
//  ImagePicker Bundle. Sandbox. FileManager
//
//  Created by Олеся on 23.03.2023.
//

import UIKit
import KeychainSwift

class LoginController: UIViewController {
    
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    private var isLogin = false
    private var counter = 0
    private let keyChain = KeychainSwift()
    override func viewDidLoad() {
        super.viewDidLoad()
print(counter)
        print(keyChain.allKeys)
    }
    

    @IBAction func buttonAction(_ sender: Any) {
        counter += 1
        
        guard let pass = passTextField.text else {
            return
        }
        if pass != "", pass.count > 4 {
            button.setTitle("Повторите пароль", for: .normal)
            print(keyChain.set(pass, forKey: "pass1"))
            
            print(counter)
            navigationController?.pushViewController(TableController(), animated: true)
        } else   if pass.count < 4 {
            passTextField.text = "Ваш пароль короткий, Необходимо более 4 символов"
        } else {
            passTextField.text = "Пароль не совпадает попробуй ещё"
        }
    }
    

}
