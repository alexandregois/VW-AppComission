//
//  VolumePenetrationVeiculosNovosModel.swift
//  App Commission
//
//  Created by Alexandre Gois on 02/08/23.
//

import Foundation

struct VolumePenetrationVeiculosNovosModel: Codable {
    
    let segmento: String?
    let nrExercicio: Int?
    let visaoAcumulada: Bool?
    let cdDn: Int?
    let grupo: String?
    let finVeiculosNovosGrupo: Int?
    let listaCdDn: [VolumePenetrationVeiculosNovosCdDnModel]
    
    enum CodingKeys: String, CodingKey {
        case segmento = "SEGMENTO"
        case nrExercicio = "NR_EXERCICIO"
        case visaoAcumulada = "VISAO_ACUMULADA"
        case cdDn = "CD_DN"
        case grupo = "GRUPO"
        case finVeiculosNovosGrupo = "FIN_VEICULOS_NOVOS_GRUPO"
        case listaCdDn = "LISTA_CD_DN"
    }
    
    init(segmento: String?, nrExercicio: Int?, visaoAcumulada: Bool?, cdDn: Int?, grupo: String?, finVeiculosNovosGrupo: Int?, listaCdDn: [VolumePenetrationVeiculosNovosCdDnModel]) {
        self.segmento = segmento
        self.nrExercicio = nrExercicio
        self.visaoAcumulada = visaoAcumulada
        self.cdDn = cdDn
        self.grupo = grupo
        self.finVeiculosNovosGrupo = finVeiculosNovosGrupo
        self.listaCdDn = listaCdDn
    }
}

struct VolumePenetrationVeiculosNovosCdDnModel: Codable {
    let cdDn: Int?
    let finVeiculosNovosCdDn: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case finVeiculosNovosCdDn = "FIN_VEICULOS_NOVOS_CD_DN"
    }
    
    init(cdDn: Int?, finVeiculosNovosCdDn: Int?) {
        self.cdDn = cdDn
        self.finVeiculosNovosCdDn = finVeiculosNovosCdDn
    }
}

