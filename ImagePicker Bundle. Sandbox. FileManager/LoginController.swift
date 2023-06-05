//
//  LoginController.swift
//  ImagePicker Bundle. Sandbox. FileManager
//
//  Created by Олеся on 23.03.2023.
//

import UIKit
import KeychainSwift

class LoginController: UIViewController {
    
    @IBOutlet weak var autorizationButton: UIButton!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    private var isLogin = false
    private var counter = 0
    private var key: String!
    private let keyChain = KeychainSwift()
    private var arrayPasswords = [String]()
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBOutlet var stateLabel: UILabel!
     
    enum State {
        case newUser
        case knownUser
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(keyChain.allKeys)
        setState(state: .newUser)
        allPass()
        
//        keyChain.clear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      passTextField?.text = nil
       
    }
    override func viewDidDisappear(_ animated: Bool) {
       setState(state: .knownUser)
    }
    
    @IBAction func switchAction(_ sender: Any) {
        if stateSwitch.isOn {
            setState(state: .knownUser)
        } else {
            setState(state: .newUser)
        }
    }
    
    @IBAction func autorizationAction(_ sender: Any) {
        print("Autorization buton tapped")
    }
    @IBAction func buttonAction(_ sender: Any) {
        guard let pass1 = passTextField.text else {
            return
        }
        
        if   !stateSwitch.isOn, counter == 0  {
            key = String(Float.random(in: 0.00...100.00))
            counter += 1
            print(counter)
            keyChain.set(pass1, forKey: String(key))
            arrayPasswords.append(pass1)
            button.setTitle("Повторите пароль", for: .normal)
            stateLabel.text = "Необходимо ввести пароль ещё раз"
            passTextField.text = nil
        } else if  comparePasswords(pass1) ,(counter >= 1)  || stateSwitch.isOn {
            isLogin = true
            goToSecondVC()
            
        } else  if pass1.count < 4 {
            counter = 0
            passTextField.text = nil
            LoginManager.showLoginAleart(in: self, with: "Ваш пароль короткий. Необходимо ввести более 4 символов")
            setState(state: .newUser)
        } else if  !comparePasswords(pass1), counter >= 1 {
            keyChain.delete(String(key))
            passTextField.text = nil
            LoginManager.showLoginAleart(in: self, with: "Пароль не совпадает попробуй ещё")
            setState(state: .newUser)
        }
    }
    
    func comparePasswords(_ pass: String) -> Bool{
        arrayPasswords.contains(pass)
    }
    
    func allPass(){
        keyChain.allKeys.forEach({ key  in
            let val = keyChain.get(key)
            arrayPasswords.append(val!)
        })
        print(arrayPasswords)
    }
    private func goToSecondVC(){
        let tab = UITabBarController()
        let filesVC = UINavigationController(rootViewController: TableController())
   
        filesVC.title = "Files"
        filesVC.tabBarItem.image = UIImage(systemName: "list.bullet")
        let settingsVC = SettingsController()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        UITabBar.appearance().backgroundColor = .secondarySystemBackground
        tab.tabBar.tintColor = .brown
        tab.viewControllers =  [filesVC, settingsVC]
        navigationController?.pushViewController(tab , animated: true)
    }
    
    private func setState(state: State) {
        switch state {
            case .newUser:
               stateLabel?.text = "Я новенький. Хочу сохраниться"
                   stateSwitch?.isOn = false
                   passTextField?.text = nil
                   counter = 0
   
            case .knownUser:
                stateLabel.text = "У меня есть пароль"
                button.setTitle("Ввести пароль", for: .normal)
                stateSwitch.isOn = true
        }
    }
}
