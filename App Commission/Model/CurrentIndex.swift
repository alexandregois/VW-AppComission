//
//  CurrentIndex.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 30/06/23.
//

import Foundation

struct CurrentIndex: Codable {
    let periodo: Int
    let cdDn: Int
    let segmento: String
    let vigente: Double
    let performado: Double
    let statico: Bool
    let grupo: String
    
    enum CodingKeys: String, CodingKey {
        case statico = "static"
        case cdDn = "cD_DN"
        case periodo = "periodo"
        case segmento = "segmento"
        case vigente = "vigente"
        case performado = "performado"
        case grupo = "grupo"
    }
    
    init(periodo: Int, cdDn: Int, segmento: String, vigente: Double, performado: Double, statico: Bool, grupo: String) {
        
        self.periodo = periodo
        self.cdDn = cdDn
        self.segmento = segmento
        self.vigente = vigente
        self.performado = performado
        self.statico = statico
        self.grupo = grupo
        
    }
}
