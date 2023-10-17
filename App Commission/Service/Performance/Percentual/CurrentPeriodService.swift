//
//  CurrentPeriodService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 10/07/23.
//

import Foundation

class CurrentPeriodService {
    static let shared = CurrentPeriodService ()
    
    let defaults = UserDefaults.standard
    
    func getVarejo(_ completion: @escaping (PerformanceCurrentPeriod?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getPeriodoVigenteVarejo!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<PerformanceCurrentPeriod,Error>) in
            switch result{
            case .success(let currentPeriod):
                completion(currentPeriod, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func getFrota(_ completion: @escaping (PerformanceCurrentPeriod?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getPeriodoVigenteFrota!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<PerformanceCurrentPeriod,Error>) in
            switch result{
            case .success(let currentPeriod):
                completion(currentPeriod, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}

