//
//  NotificationService.swift
//  App Commission
//
//  Created by Alexandre Gois on 25/07/23.
//

import Foundation

class NotificationService {
    
    static let shared = NotificationService()
    
    let defaults = UserDefaults.standard
    
    func getNotifications(_ completion: @escaping ([Notificacao]?, Error?) -> Void) {
        
        let currentUser = User.getGlobal()
        let notificationsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getNotifications!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: currentUser!.cpf!))"
        
        NetworkCall(data: nil, url: notificationsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[Notificacao],Error>) in
            switch result{
            case .success(let notifications):
                completion(notifications, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
