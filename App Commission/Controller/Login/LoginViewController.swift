//
//  LoginViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 30/05/23.
//

import Foundation
import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var rememberCpf: UISwitch!
    @IBOutlet weak var errorMsg: UILabel!
    
    var saveCpf:Bool = true
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupComponents()
        Urls.shared.env(env: Environment.development)
        UserDefaults.standard.removeObject(forKey: SystemKeys.CURRENT_TOKEN)
        UserDefaults.standard.removeObject(forKey: SystemKeys.CURRENT_USER)
    }
    
    func setupComponents() {
        nextBtn.layer.cornerRadius = 15
        nextBtn.isEnabled = false
        errorMsg.isHidden = true
        rememberCpf.onTintColor = .systemBlue
        textField.delegate = self
        rememberCpf.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        
        saveCpf = defaults.bool(forKey: SystemKeys.REMEMBER_PASSWORD)
        
        rememberCpf.isOn = saveCpf
        
        if saveCpf {
            if let userCpf = defaults.string(forKey: SystemKeys.USER_CPF) {
                textField.text = userCpf
                nextBtn.isEnabled = true
            }
        }
    
        textField.addDoneButtonOnKeyboard()
        textField.keyboardType = .asciiCapableNumberPad

    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        
        defaults.set(mySwitch.isOn, forKey: SystemKeys.REMEMBER_PASSWORD)
        
        if !mySwitch.isOn {
            defaults.set("", forKey: SystemKeys.USER_CPF)
        }
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorMsg.isHidden = true
        nextBtn.isEnabled = !textField.text!.isCPF
        
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        if allowedCharacters.isSuperset(of: characterSet) {
            var appendString = ""
            
            let  char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            
            if (isBackSpace == -92) && (textField.text?.count)! > 0 {
                textField.text!.removeLast()
                return false
            }
            
            if textField == textField
            {
                if range.length == 0 {
                    switch range.location {
                    case 3:
                        appendString = "."
                    case 7:
                        appendString = "."
                    case 11:
                        appendString = "-"
                    default:
                        break
                    }
                }
                
                if (textField.text?.count)! > 13 {
                    if !textField.text!.isCPF {
                        errorMsg.isHidden = false
                    }
                    
                    return false
                }
                textField.text?.append(appendString)
            }
            
            return true
        }else {
            return false
        }
        
        
    }
    
    @IBAction func goToNext(_ sender: Any) {
        
        if saveCpf {
            defaults.set(textField.text, forKey: SystemKeys.USER_CPF)
        }
        
        let passwordVC = PasswordViewController()
        passwordVC.userCpf = textField.text
        self.navigationController?.pushViewController(passwordVC, animated: true)
    }
}
