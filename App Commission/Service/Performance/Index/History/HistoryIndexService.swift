//
//  HistoryIndexService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 17/07/23.
//

import Foundation

class HistoryIndexService {
    static let shared = HistoryIndexService ()
    
    let defaults = UserDefaults.standard
    
    func getVarejo(_ completion: @escaping ([PerformanceHistory]?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getHistoryIndexVarejo!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[PerformanceHistory],Error>) in
            switch result{
            case .success(let performanceHistory):
                completion(performanceHistory, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func getFrota(_ completion: @escaping ([PerformanceHistory]?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getHistoryIndexFrota!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[PerformanceHistory],Error>) in
            switch result{
            case .success(let performanceHistory):
                completion(performanceHistory, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}


