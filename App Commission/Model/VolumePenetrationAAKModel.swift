//
//  VolumePenetrationAAK.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 01/08/23.
//

import Foundation

struct VolumePenetrationAAKModel: Codable {
    
    let segmento: String?
    let nrExercicio: Int?
    let visaoAcumulada: Bool?
    let cdDn: Int?
    let grupo: String?
    let aakGrupo: Int?
    let listaCdDn: [VolumePenetrationAAKCdDn]
    
    enum CodingKeys: String, CodingKey {
        case segmento = "SEGMENTO"
        case nrExercicio = "NR_EXERCICIO"
        case visaoAcumulada = "VISAO_ACUMULADA"
        case cdDn = "CD_DN"
        case grupo = "GRUPO"
        case aakGrupo = "AAK_GRUPO"
        case listaCdDn = "LISTA_CD_DN"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        segmento = try container.decodeIfPresent(String.self, forKey: .segmento)
        nrExercicio = try container.decodeIfPresent(Int.self, forKey: .nrExercicio)
        visaoAcumulada = try container.decodeIfPresent(Bool.self, forKey: .visaoAcumulada)
        cdDn = try container.decodeIfPresent(Int.self, forKey: .cdDn)
        grupo = try container.decodeIfPresent(String.self, forKey: .grupo)
        aakGrupo = try container.decode(Int.self, forKey: .aakGrupo)
        listaCdDn = try container.decodeIfPresent([VolumePenetrationAAKCdDn].self, forKey: .listaCdDn) ?? []
    }
    
}


struct VolumePenetrationAAKCdDn: Codable {
    let cdDn: Int?
    let aakCdDn: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case aakCdDn = "AAK_CD_DN"
    }
    
    init(cdDn: Int, aakCdDn: Int) {
        
        self.cdDn = cdDn
        self.aakCdDn = aakCdDn
    }
    
}
