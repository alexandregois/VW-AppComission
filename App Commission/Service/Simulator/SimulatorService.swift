//
//  SimulatorService.swift
//  App Commission
//
//  Created by Alexandre Gois on 12/07/23.
//

import Foundation

class SimulatorService {
    
    static let shared = SimulatorService()
    
    let defaults = UserDefaults.standard
    let grantType = "password"
    
    func getSimulatorRealizado(_ completion: @escaping (SimulatorRealizado?, Error?) -> Void) {
        
        let actualPeriod = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        
        let simulatorUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getSimulatorRealizado!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriod!))"
        
        NetworkCall(data: nil, url: simulatorUrl, service: nil, method: .get).executeQuery(){
            (result: Result<SimulatorRealizado,Error>) in
            switch result{
            case .success(let simulator):
                completion(simulator, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
    
    func postSimulatorProjection(body: [String: Any], completion: @escaping (SimulatorProjection?, Error?) -> Void) {
        let simulatorUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.postSimuladorProjection!))"
        
        NetworkCall(data: body, url: simulatorUrl, service: nil, method: .post).executeJsonQuery(){
            (result: Result<SimulatorProjection,Error>) in
            switch result{
            case .success(let simulatorProjection):
                completion(simulatorProjection, nil)
                
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }

}
