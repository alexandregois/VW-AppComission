//
//  PeriodoService.swift
//  App Commission
//
//  Created by Alexandre Gois on 22/06/23.
//

import Foundation

class ServicePeriod {
    static let shared = ServicePeriod()
    
    let defaults = UserDefaults.standard
    
    func getPeriod(_ completion: @escaping ([Period]?, Error?) -> Void) {
        
        let currentUser = User.getGlobal()
        let periodoUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getPeriod!))"
        
        NetworkCall(data: nil, url: periodoUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[Period],Error>) in
            switch result{
            case .success(let periodo):
                completion(periodo, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
