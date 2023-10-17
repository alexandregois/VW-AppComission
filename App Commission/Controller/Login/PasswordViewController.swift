//
//  PasswordViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 05/06/23.
//

import Foundation
import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var passwordEye: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    
    var isShowPass = false
    
    var userCpf:String!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let userPassword = defaults.string(forKey: SystemKeys.USER_PASSWORD) {
            passwordTextField.text = userPassword
        }
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        setupComponents()
    }
    
    func setupComponents() {
        loginBtn.layer.cornerRadius = 15
        passwordTextField.isSecureTextEntry = true
        passwordEye.isUserInteractionEnabled = true
        passwordEye.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.showPassword)))
        loginBtn.addTarget(self, action: #selector(doLogin), for: .touchUpInside)
        passwordTextField.addDoneButtonOnKeyboard()
    }
    
    @objc func showPassword() {
        if isShowPass {
            isShowPass = false
            passwordTextField.isSecureTextEntry = true
            passwordEye.image = UIImage(named: "icon_eye_open")
        } else {
            isShowPass = true
            passwordTextField.isSecureTextEntry = false
            passwordEye.image = UIImage(named: "icon_eye_closed")
        }
    }
    
    @objc func doLogin() {
        self.createSpinnerView()
        LoginService.shared.doLogin(cpf: userCpf, password: passwordTextField.text!)  { user, error in
            if user != nil {
                self.defaults.set(self.passwordTextField.text!, forKey: SystemKeys.USER_PASSWORD)
                DataService.shared.getPeriodoAtual { periodoAtual, error in
                    if periodoAtual != nil {
                        self.defaults.set(periodoAtual, forKey: SystemKeys.ACTUAL_PERIOD)
                        
                        DataService.shared.getDataCarga { dataCarga, error in
                            self.removeSpinnerView()
                            if dataCarga != nil {
                                self.defaults.set(dataCarga, forKey: SystemKeys.DATA_CARGA)
                                
                                ProfileAccess.shared.setUserProfile(role: user!.userRoles)
                                ProfileAccess.shared.userAccess(prof: ProfileAccess.shared.profile)
                                self.errorMsg.isHidden = true
                                
                                let tabBarVC = UITabBarController()
                                if ProfileAccess.shared.profile == .lop || ProfileAccess.shared.profile == .lof {
                                    let periodVc = UINavigationController(rootViewController: PeriodViewController())
                                    periodVc.title = "Periodo"
                                    let newsVc = UINavigationController(rootViewController: NewsViewController())
                                    newsVc.title = "Notícias"
                                    let performanceVc = UINavigationController(rootViewController: PerformanceViewController())
                                    performanceVc.title = "Desempenho"
                                    tabBarVC.setViewControllers([newsVc, performanceVc, periodVc], animated: false)
                                    
                                    guard let items = tabBarVC.tabBar.items else {
                                        return
                                    }
                                    let images = ["icon_news", "icon_performance", "icon_period"]
                                    
                                    for x in 0..<items.count {
                                        items[x].image = UIImage(named: images[x])
                                    }
                                    
                                } else {
                                    
                                    let periodVc = UINavigationController(rootViewController: PeriodViewController())
                                    periodVc.title = "Periodo"
                                    let newsVc = UINavigationController(rootViewController: NewsViewController())
                                    newsVc.title = "Notícias"
                                    let simulatorVc = UINavigationController(rootViewController: SimulatorViewController())
                                    simulatorVc.title = "Simulador"
                                    let performanceVc = UINavigationController(rootViewController: PerformanceViewController())
                                    performanceVc.title = "Desempenho"
                                    tabBarVC.setViewControllers([newsVc, performanceVc, simulatorVc, periodVc], animated: false)
                                    
                                    guard let items = tabBarVC.tabBar.items else {
                                        return
                                    }
                                    let images = ["icon_news", "icon_performance", "icon_simulator", "icon_period"]
                                    
                                    for x in 0..<items.count {
                                        items[x].image = UIImage(named: images[x])
                                    }
                                }
                                tabBarVC.modalPresentationStyle = .fullScreen
                                tabBarVC.tabBar.backgroundColor = .white
                                self.present(tabBarVC, animated: true)
                            }
                            
                            if error != nil {
                                print(error)
                                self.removeSpinnerView()
                                self.errorMsg.text = "Estamos com problemas internos...Tente novamente"
                                self.errorMsg.isHidden = false
                            }
                        }
                    }
                }
                
                if error != nil {
                    print(error)
                    self.removeSpinnerView()
                    self.errorMsg.text = "Estamos com problemas internos...Tente novamente"
                    self.errorMsg.isHidden = false
                }
                
            }
            
            if error != nil {
                print(error)
                self.removeSpinnerView()
                self.errorMsg.isHidden = false
            }
        }
    }
}

