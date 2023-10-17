//
//  VolumePenetrationISRModel.swift
//  App Commission
//
//  Created by Alexandre Gois on 14/08/23.
//

import Foundation

struct VolumePenetrationISRModel: Codable {
    
    let segmento: String?
    let nrExercicio: Int?
    let visaoAcumulada: Bool?
    let cdDn: Int?
    let grupo: String?
    let isrGrupo: Float?
    let listaCdDn: [VolumePenetrationISRCdDnModel]
    
    enum CodingKeys: String, CodingKey {
        case segmento = "SEGMENTO"
        case nrExercicio = "NR_EXERCICIO"
        case visaoAcumulada = "VISAO_ACUMULADA"
        case cdDn = "CD_DN"
        case grupo = "GRUPO"
        case isrGrupo = "ISR_GRUPO"
        case listaCdDn = "LISTA_CD_DN"
    }
    
    init(segmento: String?, nrExercicio: Int?, visaoAcumulada: Bool?, cdDn: Int?, grupo: String?, isrGrupo: Float?, listaCdDn: [VolumePenetrationISRCdDnModel]) {
        self.segmento = segmento
        self.nrExercicio = nrExercicio
        self.visaoAcumulada = visaoAcumulada
        self.cdDn = cdDn
        self.grupo = grupo
        self.isrGrupo = isrGrupo
        self.listaCdDn = listaCdDn
    }
}

struct VolumePenetrationISRCdDnModel: Codable {
    let cdDn: Int?
    let valueCdDn: Float?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valueCdDn = "ISR_CD_DN"
    }
    
    init(cdDn: Int?, isrCdDn: Float?) {
        self.cdDn = cdDn
        self.valueCdDn = isrCdDn
    }
}
