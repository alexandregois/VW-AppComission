//
//  DataService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 03/07/23.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    let defaults = UserDefaults.standard
    
    func getDataCarga(_ completion: @escaping (String?, Error?) -> Void) {
        
        let url = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getDataCarga!))"
        
        NetworkCall(data: nil, url: url, service: nil, method: .get).executeQuery(){
            (result: Result<String,Error>) in
            switch result{
            case .success(let dataCarga):
                completion(dataCarga, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getPeriodoAtual(_ completion: @escaping (String?, Error?) -> Void) {
        
        let url = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getActualPeriod!))"
        
        NetworkCall(data: nil, url: url, service: nil, method: .get).executeQuery(){
            (result: Result<String,Error>) in
            switch result{
            case .success(let periodo):
                
                completion(periodo, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
