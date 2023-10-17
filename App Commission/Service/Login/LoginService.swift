//
//  LoginService.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 14/06/23.
//

import Foundation

class LoginService {
    
    static let shared = LoginService()
    
    let defaults = UserDefaults.standard
    let grantType = "password"
    
    func doLogin(cpf:String, password:String, _ completion: @escaping (User?, Error?) -> Void) {
        let body: [String : Any] = ["client_id": Urls.shared.keyCloakClientId,
                                    "client_secret": Urls.shared.keyclokClientSecret,
                                    "grant_type": grantType,
                                    "username": cpf.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: ""),
                                    "password": password,
        ]
        
        NetworkCall(data: body, url: Urls.shared.keyclockUrl, service: nil, method: .post).executeQuery(){
            (result: Result<Token,Error>) in
            switch result{
            case .success(let token):
                
                token.saveGlobal()
                
                let parts = token.access_token.components(separatedBy: ".")
                
                let decodedToken =  self.decodeJWTPart(part: parts[1])
                
                
                var userRole = ""
                
                
                if let theArray = decodedToken!["user_roles"] as? [String] {
                    if let element = theArray.first {
                        userRole = element
                    }
                }
                
                let user = User(sid: decodedToken!["sid"] as! String, filial: decodedToken!["filial"] as! String, nomeFilial: decodedToken!["nome_filial"] as! String, montadora: decodedToken!["montadora"] as! String, cargo: decodedToken!["cargo"] as! String, codigoDealer: decodedToken!["codigo_dealer"] as! String, sub: decodedToken!["sub"] as! String, userRoles: userRole as! String, email: decodedToken!["email"] as! String, preferredUsername: decodedToken!["preferred_username"] as! String, name: decodedToken!["name"] as! String, cpf: cpf.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: ""))
                
                user.saveGlobal()
                
                completion(user, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func base64StringWithPadding(encodedString: String) -> String {
        var stringTobeEncoded = encodedString.replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let paddingCount = encodedString.count % 4
        for _ in 0..<paddingCount {
            stringTobeEncoded += "="
        }
        return stringTobeEncoded
    }
    
    func decodeJWTPart(part: String) -> [String: Any]? {
        let payloadPaddingString = base64StringWithPadding(encodedString: part)
        guard let payloadData = Data(base64Encoded: payloadPaddingString) else {
            fatalError("payload could not converted to data")
        }
        return try? JSONSerialization.jsonObject(
            with: payloadData,
            options: []) as? [String: Any]
    }
}
