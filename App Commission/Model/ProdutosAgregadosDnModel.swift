//
//  ProdutosAgregadosDnModel.swift
//  App Commission
//
//  Created by Alexandre Gois on 16/08/23.
//

import Foundation

struct ProdutosAgregadosDnModel: Codable {
    let listCdDn: [String]
    let grupo: String

    enum CodingKeys: String, CodingKey {
        case listCdDn = "List_Cd_Dn"
        case grupo = "Grupo"
    }
}
