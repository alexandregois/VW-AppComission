//
//  IndiceAceleraService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 17/07/23.
//

import Foundation

class IndiceAceleraService {
    static let shared = IndiceAceleraService()
    
    let defaults = UserDefaults.standard
    
    func getVarejo(_ completion: @escaping ([IndiceAcelera]?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getIndiceAceleraVarejo!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[IndiceAcelera],Error>) in
            switch result{
            case .success(let indiceAcelera):
                completion(indiceAcelera, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func getFrota(_ completion: @escaping ([IndiceAcelera]?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getIndiceAceleraFrota!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[IndiceAcelera],Error>) in
            switch result{
            case .success(let indiceAcelera):
                completion(indiceAcelera, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
