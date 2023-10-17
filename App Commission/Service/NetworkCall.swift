//
//  File.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 14/06/23.
//

import Foundation
import Alamofire

class NetworkCall : NSObject {
    
    enum services :String{
        case login = "token"
    }
    var parameters = Parameters()
    var headers = HTTPHeaders()
    var method: HTTPMethod!
    var url: String! = ""
    var encoding: ParameterEncoding! = URLEncoding.default
    var token: Token?
    
    
    init(data: [String:Any]? = nil, headers: [String:String] = [:],url :String, service :services? = nil, method: HTTPMethod = .get, isJSONRequest: Bool = true){
        super.init()
        if data != nil {
            data!.forEach{parameters.updateValue($0.value, forKey: $0.key)}
        }
        
        
        if let token = Token.getGlobal() {
            if method == .get {
                self.headers = [
                    "Accept": "*/*",
                    "Content-type": "application/x-www-form-urlencoded",
                    "Cache-control": "no-cache"
                ]
            } else {
                encoding = URLEncoding.httpBody
                self.headers = [
                    "Accept": "*/*",
                    "Content-type": "application/json",
                    "Cache-control": "no-cache"
                ]
                }
        } else {
            self.headers = [
                "Accept": "*/*",
                "Content-type": "application/x-www-form-urlencoded",
                "Cache-control": "no-cache"
            ]
        }
        
        
        if let token = Token.getGlobal() {
            self.headers.add(name: "x_access_token", value: token.access_token)
            self.headers.add(name: "X-IBM-Client-Id", value: Urls.shared.clientId)
            self.headers.add(name: "X-IBM-Client-Secret", value: Urls.shared.clientSecret)
        }
        
        headers.forEach({self.headers.add(name: $0.key, value: $0.value)})
        if service != nil{
            self.url += service!.rawValue
        }else{
            self.url = url
        }
        if !isJSONRequest {
            encoding = URLEncoding.default
        }
        self.method = method
        print("Service: \(service?.rawValue ?? self.url ?? "") \n data: \(parameters)")
    }
    
    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        AF.request(url,method: method,parameters: parameters,encoding: encoding, headers: headers).responseData(completionHandler: {response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            print(String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                        //                    case 400...404:
                        //                        if let token = Token.getGlobal() {
                        //                            let body: [String : Any] = ["client_id": Urls.shared.keyCloakClientId,
                        //                                                        "client_secret": Urls.shared.keyclokClientSecret,
                        //                                                        "grant_type": "refresh_token",
                        //                                                        "refresh_token": token.refresh_token,
                        //                            ]
                        //
                        //                            self.parameters = Parameters()
                        //
                        //                            body.forEach{self.parameters.updateValue($0.value, forKey: $0.key)}
                        //
                        //                            self.headers = [
                        //                                "Accept": "*/*",
                        //                                "Content-type": "application/x-www-form-urlencoded",
                        //                                "Cache-control": "no-cache"
                        //                            ]
                        //
                        //                            self.method = .post
                        //                            let refreshTokenURL = Urls.shared.keyclockUrl
                        //
                        //                            AF.request(refreshTokenURL,method: self.method,parameters: self.parameters,encoding: self.encoding, headers: self.headers).responseData(completionHandler: {response in
                        //                                switch response.result{
                        //
                        //                                case .success(let res):
                        //                                    print("success")
                        //                                case .failure(let error):
                        //                                    print("failed")
                        //                                }
                        //                            })
                        //                        }
                        
                    default:
                        let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        
                        //                        if let token = Token.getGlobal() {
                        //                            UserDefaults.standard.removeObject(forKey: SystemKeys.CURRENT_TOKEN)
                        //                            UserDefaults.standard.removeObject(forKey: SystemKeys.CURRENT_USER)
                        //
                        //                            let story = UIStoryboard(name: "Main", bundle:nil)
                        //                            let loginVc = story.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
                        //                            UIApplication.shared.windows.first?.rootViewController = loginVc
                        //                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        //                        }
                        
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func executeJsonQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        
        AF.request(url,method: method,parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: {response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
                        
                        do {
                            let jsonString = self.convertDictionaryToJSON(res as! [String : Any])
                            
                            if jsonString != nil {
                                do {
                                    let jsonData = Data(jsonString!.utf8)
                                    let simulatorProjection = try JSONDecoder().decode(T.self, from: jsonData)
                                    print(simulatorProjection)
                                    completion(.success(simulatorProjection))
                                } catch {
                                    print(error.localizedDescription)
                                    completion(.failure(error))
                                }
                            } else {
                                
                                var error = NSError(domain:"", code:500, userInfo:nil)

                                completion(.failure(error))
                            }
                            
                        }
                        //                    case 400...404:
                        //                        if let token = Token.getGlobal() {
                        //                            let body: [String : Any] = ["client_id": Urls.shared.keyCloakClientId,
                        //                                                        "client_secret": Urls.shared.keyclokClientSecret,
                        //                                                        "grant_type": "refresh_token",
                        //                                                        "refresh_token": token.refresh_token,
                        //                            ]
                        //
                        //                            self.parameters = Parameters()
                        //
                        //                            body.forEach{self.parameters.updateValue($0.value, forKey: $0.key)}
                        //
                        //                            self.headers = [
                        //                                "Accept": "*/*",
                        //                                "Content-type": "application/x-www-form-urlencoded",
                        //                                "Cache-control": "no-cache"
                        //                            ]
                        //
                        //                            self.method = .post
                        //                            let refreshTokenURL = Urls.shared.keyclockUrl
                        //
                        //                            AF.request(refreshTokenURL,method: self.method,parameters: self.parameters,encoding: self.encoding, headers: self.headers).responseData(completionHandler: {response in
                        //                                switch response.result{
                        //
                        //                                case .success(let res):
                        //                                    print("success")
                        //                                case .failure(let error):
                        //                                    print("failed")
                        //                                }
                        //                            })
                        //                        }
                        
                    default:
                        let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        
                        //                        if let token = Token.getGlobal() {
                        //                            UserDefaults.standard.removeObject(forKey: SystemKeys.CURRENT_TOKEN)
                        //                            UserDefaults.standard.removeObject(forKey: SystemKeys.CURRENT_USER)
                        //
                        //                            let story = UIStoryboard(name: "Main", bundle:nil)
                        //                            let loginVc = story.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
                        //                            UIApplication.shared.windows.first?.rootViewController = loginVc
                        //                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        //                        }
                        
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func convertDictionaryToJSON(_ dictionary: [String: Any]) -> String? {

        
       guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
          print("Something is wrong while converting dictionary to JSON data.")
          return nil
       }

       guard let jsonString = String(data: jsonData, encoding: .utf8) else {
          print("Something is wrong while converting JSON data to JSON string.")
          return nil
       }

       return jsonString
    }
    
}
