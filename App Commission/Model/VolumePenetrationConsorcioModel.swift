//
//  VolumePenetrationConsorcioModel.swift
//  App Commission
//
//  Created by Alexandre Gois on 02/08/23.
//

import Foundation

struct VolumePenetrationConsorcioModel: Codable {
    
    let segmento: String?
    let nrExercicio: Int?
    let visaoAcumulada: Bool?
    let cdDn: Int?
    let grupo: String?
    let consorcioGrupo: Int?
    let listaCdDn: [VolumePenetrationConsorcioCdDnModel]
    
    enum CodingKeys: String, CodingKey {
        case segmento = "SEGMENTO"
        case nrExercicio = "NR_EXERCICIO"
        case visaoAcumulada = "VISAO_ACUMULADA"
        case cdDn = "CD_DN"
        case grupo = "GRUPO"
        case consorcioGrupo = "CONSORCIO_GRUPO"
        case listaCdDn = "LISTA_CD_DN"
    }
    
    init(segmento: String?, nrExercicio: Int?, visaoAcumulada: Bool?, cdDn: Int?, grupo: String?, consorcioGrupo: Int?, listaCdDn: [VolumePenetrationConsorcioCdDnModel]) {
        self.segmento = segmento
        self.nrExercicio = nrExercicio
        self.visaoAcumulada = visaoAcumulada
        self.cdDn = cdDn
        self.grupo = grupo
        self.consorcioGrupo = consorcioGrupo
        self.listaCdDn = listaCdDn
    }
}

struct VolumePenetrationConsorcioCdDnModel: Codable {
    let cdDn: Int?
    let consorcioCdDn: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case consorcioCdDn = "CONSORCIO_CD_DN"
    }
    
    init(cdDn: Int?, consorcioCdDn: Int?) {
        self.cdDn = cdDn
        self.consorcioCdDn = consorcioCdDn
    }
}

