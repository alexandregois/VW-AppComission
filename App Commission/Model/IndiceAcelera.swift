//
//  IndiceAceleraModel.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 17/07/23.
//

import Foundation

struct IndiceAcelera: Codable {
    let indiceVarejo: String
    let programaAcelera: String
    let periodo: Int
    
    enum CodingKeys: String, CodingKey {
        case indiceVarejo = "INDICE_VAREJO"
        case programaAcelera = "PROGRAMA_ACELERA"
        case periodo = "PERIODO"
    }
    
    init(indiceVarejo: String, programaAcelera: String, periodo: Int) {
        self.periodo = periodo
        self.indiceVarejo = indiceVarejo
        self.programaAcelera = programaAcelera
        
    }
}
