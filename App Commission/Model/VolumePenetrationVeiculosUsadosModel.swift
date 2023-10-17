//
//  VolumePenetrationVeiculosUsadosModel.swift
//  App Commission
//
//  Created by Alexandre Gois on 02/08/23.
//

import Foundation

struct VolumePenetrationVeiculosUsadosModel: Codable {
    
    let segmento: String?
    let nrExercicio: Int?
    let visaoAcumulada: Bool?
    let cdDn: Int?
    let grupo: String?
    let finVeiculosUsadosGrupo: Int?
    let listaCdDn: [VolumePenetrationVeiculosUsadosCdDnModel]
    
    enum CodingKeys: String, CodingKey {
        case segmento = "SEGMENTO"
        case nrExercicio = "NR_EXERCICIO"
        case visaoAcumulada = "VISAO_ACUMULADA"
        case cdDn = "CD_DN"
        case grupo = "GRUPO"
        case finVeiculosUsadosGrupo = "FIN_VEICULOS_USADOS_GRUPO"
        case listaCdDn = "LISTA_CD_DN"
    }
    
    init(segmento: String?, nrExercicio: Int?, visaoAcumulada: Bool?, cdDn: Int?, grupo: String?, finVeiculosUsadosGrupo: Int?, listaCdDn: [VolumePenetrationVeiculosUsadosCdDnModel]) {
        self.segmento = segmento
        self.nrExercicio = nrExercicio
        self.visaoAcumulada = visaoAcumulada
        self.cdDn = cdDn
        self.grupo = grupo
        self.finVeiculosUsadosGrupo = finVeiculosUsadosGrupo
        self.listaCdDn = listaCdDn
    }
}

struct VolumePenetrationVeiculosUsadosCdDnModel: Codable {
    let cdDn: Int?
    let finVeiculosUsadosCdDn: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case finVeiculosUsadosCdDn = "FIN_VEICULOS_USADOS_CD_DN"
    }
    
    init(cdDn: Int?, finVeiculosUsadosCdDn: Int?) {
        self.cdDn = cdDn
        self.finVeiculosUsadosCdDn = finVeiculosUsadosCdDn
    }
}

