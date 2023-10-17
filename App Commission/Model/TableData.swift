//
//  FullTable.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 11/07/23.
//

import Foundation

struct TableData: Codable {
    
    let negociadoVertical: [String]
    let referenciaHorizontal: [String]
    let valores: [[String]]
    
    enum CodingKeys: String, CodingKey {
        case negociadoVertical = "NEGOCIADO_VERTICAL"
        case referenciaHorizontal = "REFERENCIA_HORIZONTAL"
        case valores = "VALORES"
    }
    
    init(negociadoVertical: [String], referenciaHorizontal: [String], valores: [[String]]) {
        self.negociadoVertical = negociadoVertical
        self.referenciaHorizontal = referenciaHorizontal
        self.valores = valores
    }
}
