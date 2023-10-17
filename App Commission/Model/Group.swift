//
//  Grupo.swift
//  App Commission
//
//  Created by Alexandre Gois on 19/06/23.
//

import Foundation

struct Group : Codable {
    
        let grupoComission: String
        let dealers: [Dealer]

        enum CodingKeys: String, CodingKey {
            case grupoComission = "GRUPO_COMISSION"
            case dealers = "DEALERS"
        }

    init(grupoComission: String, dealers: [Dealer]) {

        self.grupoComission = grupoComission
        self.dealers = dealers

    }
    
}
