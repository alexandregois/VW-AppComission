//
//  User.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 30/05/23.
//

import Foundation

struct User : Codable {

    let sid: String!
    let filial: String!
    var nomeFilial: String!
    let montadora: String!
    let cargo: String!
    var codigoDealer: String!
    let sub: String!
    let userRoles: String!
    let email: String!
    let preferredUsername: String!
    let name: String!
    let cpf: String!
    
    init(sid: String, filial: String, nomeFilial: String, montadora: String, cargo: String, codigoDealer: String, sub: String, userRoles: String, email: String, preferredUsername: String, name: String, cpf: String) {
        self.sid = sid
        self.filial = filial
        self.nomeFilial = nomeFilial
        self.montadora = montadora
        self.cargo = cargo
        self.codigoDealer = codigoDealer
        self.sub = sub
        self.userRoles = userRoles
        self.email = email
        self.preferredUsername = preferredUsername
        self.name = name
        self.cpf = cpf
    }
    
    func saveGlobal() {
        do {
            let encoder = JSONEncoder()

            let data = try encoder.encode(self)

            UserDefaults.standard.set(data, forKey: SystemKeys.CURRENT_USER)

        } catch {
            print("Unable to Encode User (\(error))")
        }
    }
    
   static func getGlobal() -> User? {
        
        do {
            let decoder = JSONDecoder()
            
            var user = try decoder.decode(User.self, from: UserDefaults.standard.data(forKey: SystemKeys.CURRENT_USER)!)
            
            return user
            
        } catch {
            print("Unable to Decode User (\(error))")
        
            return nil
        }
        
    }
}
