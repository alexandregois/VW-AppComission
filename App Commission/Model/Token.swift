//
//  Token.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 14/06/23.
//

import Foundation

struct Token: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_expires_in: Int
    let refresh_token: String
    let token_type: String
    let scope: String
    
    
    func saveGlobal() {
        do {
            let encoder = JSONEncoder()

            let data = try encoder.encode(self)

            UserDefaults.standard.set(data, forKey: SystemKeys.CURRENT_TOKEN)

        } catch {
            print("Unable to Encode Token (\(error))")
        }
    }
    
   static func getGlobal() -> Token? {
        
        do {
            let decoder = JSONDecoder()
            
            if UserDefaults.standard.object(forKey: SystemKeys.CURRENT_TOKEN) != nil {
                var token = try decoder.decode(Token.self, from: UserDefaults.standard.data(forKey: SystemKeys.CURRENT_TOKEN)!)
                return token
            }
            
            return nil
            
            
        } catch {
            print("Unable to Decode Token (\(error))")
        
            return nil
        }
        
    }
}
