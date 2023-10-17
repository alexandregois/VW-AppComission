//
//  NewsService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 20/06/23.
//

import Foundation

class NewsService {
    static let shared = NewsService()
    
    let defaults = UserDefaults.standard
    
    func getNews(_ completion: @escaping ([New]?, Error?) -> Void) {
        
        let currentUser = User.getGlobal()
        let newsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getNews!))\(String(describing: currentUser!.codigoDealer!))/\(String(describing: currentUser!.cpf!))"
        
        NetworkCall(data: nil, url: newsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<[New],Error>) in
            switch result{
            case .success(let news):
                completion(news, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
