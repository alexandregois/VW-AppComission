//
//  CurrentIndexService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 30/06/23.
//

import Foundation

class CurrentIndexService {
    static let shared = CurrentIndexService()
    
    let defaults = UserDefaults.standard
    
    func getVarejo(_ completion: @escaping ([CurrentIndex]?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getIndiceVigenteVarejo!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[CurrentIndex],Error>) in
            switch result{
            case .success(let currentIndexs):
                completion(currentIndexs, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func getFrota(_ completion: @escaping ([CurrentIndex]?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getIndiceVigenteFrota!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[CurrentIndex],Error>) in
            switch result{
            case .success(let currentIndexs):
                completion(currentIndexs, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
