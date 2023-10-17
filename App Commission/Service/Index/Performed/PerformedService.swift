//
//  PerformedService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 11/07/23.
//

import Foundation

class PerformedService {
    static let shared = PerformedService()
    
    let defaults = UserDefaults.standard
    
    func getVarejo(_ completion: @escaping (PerformedIndex?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getPerformedIndexVarejo!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<PerformedIndex,Error>) in
            switch result{
            case .success(let performedIndex):
                completion(performedIndex, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func getFrota(_ completion: @escaping (PerformedIndex?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getPerformedIndexFrota!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<PerformedIndex,Error>) in
            switch result{
            case .success(let performedIndex):
                completion(performedIndex, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func getAcelera(_ completion: @escaping (PerformedIndex?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getPerformedIndexAcelera!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<PerformedIndex,Error>) in
            switch result{
            case .success(let performedIndex):
                completion(performedIndex, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}


