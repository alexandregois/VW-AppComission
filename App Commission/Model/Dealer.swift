//
//  Dealer.swift
//  App Commission
//
//  Created by Alexandre Gois on 21/06/23.
//

import Foundation

struct Dealer : Codable {
    
    let cdDN: Int
    let grupoComission: String
    let perfil: String
    
    enum CodingKeys: String, CodingKey {
        case cdDN = "CD_DN"
        case grupoComission = "GRUPO_COMISSION"
        case perfil = "PERFIL"
    }
    
    init(cdDN: Int, grupoComission: String, perfil: String) {
        
        self.cdDN = cdDN
        self.grupoComission = grupoComission
        self.perfil = perfil
        
    }
    
}
