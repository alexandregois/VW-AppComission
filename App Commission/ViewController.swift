//
//  ViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 31/05/23.
//

import UIKit
//import Reachability

class ViewController: UIViewController {
    
    @IBOutlet weak var myCustomView: UIView! // Conecte isso ao seu UIView no storyboard
    
//    let reachability = try! Reachability()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
//            internetConnection()
            
            // Configuração de bordas arredondadas
            myCustomView.layer.cornerRadius = 20
            
            // Configuração da sombra
            myCustomView.layer.shadowColor = UIColor.gray.cgColor
            myCustomView.layer.shadowOffset = CGSize(width: 5, height: 5)
            myCustomView.layer.shadowRadius = 10
            myCustomView.layer.shadowOpacity = 1
        }
    
//    func internetConnection()
//    {
//        reachability.whenReachable = { reachability in
//                   if reachability.connection == .wifi {
//                       print("Conectado via WiFi")
//                   } else {
//                       print("Conectado via Celular")
//                   }
//               }
//               reachability.whenUnreachable = { _ in
//                   print("Sem conexão de internet")
//                   let alert = UIAlertController(title: "Sem Conexão", message: "Verifique sua conexão de internet.", preferredStyle: .alert)
//                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                   self.present(alert, animated: true, completion: nil)
//               }
//
//               do {
//                   try reachability.startNotifier()
//               } catch {
//                   print("Erro ao iniciar notificador de reachability")
//               }
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }


}

