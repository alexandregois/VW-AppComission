//
//  VolumePenetrationPenetrationModel.swift
//  App Commission
//
//  Created by Alexandre Gois on 02/08/23.
//

import Foundation

struct VolumePenetrationPenetrationModel: Codable {
    
    let segmento: String?
    let nrExercicio: Int?
    let visaoAcumulada: Bool?
    let cdDn: Int?
    let grupo: String?
    let penetrationGrupo: Float?
    let listaCdDn: [VolumePenetrationPenetrationCdDnModel]
    
    enum CodingKeys: String, CodingKey {
        case segmento = "SEGMENTO"
        case nrExercicio = "NR_EXERCICIO"
        case visaoAcumulada = "VISAO_ACUMULADA"
        case cdDn = "CD_DN"
        case grupo = "GRUPO"
        case penetrationGrupo = "PENETRATION_GRUPO"
        case listaCdDn = "LISTA_CD_DN"
    }
    
    init(segmento: String?, nrExercicio: Int?, visaoAcumulada: Bool?, cdDn: Int?, grupo: String?, penetrationGrupo: Float?, listaCdDn: [VolumePenetrationPenetrationCdDnModel]) {
        self.segmento = segmento
        self.nrExercicio = nrExercicio
        self.visaoAcumulada = visaoAcumulada
        self.cdDn = cdDn
        self.grupo = grupo
        self.penetrationGrupo = penetrationGrupo
        self.listaCdDn = listaCdDn
    }
}

struct VolumePenetrationPenetrationCdDnModel: Codable {
    let cdDn: Int?
    let penetrationCdDn: Float?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case penetrationCdDn = "PENETRATION_CD_DN"
    }
    
    init(cdDn: Int?, penetrationCdDn: Float?) {
        self.cdDn = cdDn
        self.penetrationCdDn = penetrationCdDn
    }
}


