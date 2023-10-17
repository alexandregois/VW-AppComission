//
//  CurrentPeriod.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 10/07/23.
//

import Foundation


struct CurrentPeriod : Codable {
    
    let periodo: Int?
    let grupo: String?
    let cdDn: Int?
    let cdRegional: String?
    let segmento: String?
    let isrGrupo: Double?
    let isrBr: Double?
    let isrRegional: Double?
    let penetrationGrupo: Double?
    let penetrationBr: Double?
    let penetrationRegional: Double?
    
    enum CodingKeys: String, CodingKey {
        case periodo = "PERIOCO"
        case grupo = "GRUPO"
        case cdDn = "CD_DN"
        case cdRegional = "CD_REGIONAL"
        case segmento = "SEGMENTO"
        case isrGrupo = "ISR_GRUPO"
        case isrBr = "ISR_BR"
        case isrRegional = "ISR_REGIONAL"
        case penetrationGrupo = "PENETRATION_GRUPO"
        case penetrationBr = "PENETRATION_BR"
        case penetrationRegional = "PENETRATION_REGIONAL"
    }
    
    init(periodo: Int, grupo: String, cdDn: Int,cdReginal: String,segmento: String,isrGrupo: Double,isrBr: Double, isrRegional: Double, penetrationGrupo: Double, penetrationBr: Double, penetrationRegional: Double) {
        
        self.periodo = periodo
        self.grupo = grupo
        self.cdDn = cdDn
        self.cdRegional = cdReginal
        self.segmento = segmento
        self.isrBr = isrBr
        self.isrGrupo = isrGrupo
        self.isrRegional = isrRegional
        self.penetrationBr = penetrationBr
        self.penetrationGrupo = penetrationGrupo
        self.penetrationRegional = penetrationRegional
    }
}
