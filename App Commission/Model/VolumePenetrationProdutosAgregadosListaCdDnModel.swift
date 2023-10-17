//
//  VolumePenetrationProdutosAgregadosListaCdDnModel.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 17/08/23.
//

import Foundation

struct VolumePenetrationProdutosAgregadosListaCdDnModel: Codable {
    
    let listAcidentesPessoas: [AcidentesPessoais]?
    let listFranquia: [Franquia]?
    let listGap: [Gap]?
    let listGarantiaEstMecanicaTot: [GarantiaEstMecanicaTot]?
    let listGarantiaEstEndIDACLP: [GarantiaEstEndIDACLP]?
    let listGarantiaEstClpFin: [GarantiaEstClpFin]?
    let listGarantiaEstClpAvi: [GarantiaEstClpAvi]?
    let listGarantiaEstendidaVw: [GarantiaEstendidaVw]?
    let listGarantiaEstendidaVwFin: [GarantiaEstendidaVwFin]?
    let listGarantiaEstendidaVwAvi: [GarantiaEstendidaVwAvi]?
    let listGEVwEssencial12: [GEVwEssencial12]?
    let listGEVwEssencial24: [GEVwEssencial24]?
    let listGEVWEssenModelo12: [GEVWEssenModelo12]?
    let listGEVWEssenModelo24: [GEVWEssenModelo24]?
    let listGEVWEssenModelo36: [GEVWEssenModelo36]?
    let listGEVWEssenModelo48: [GEVWEssenModelo48]?
    let listGEVWTotalModelo12: [GEVWTotalModelo12]?
    let TOTAL_GRUPO_ACIDENTES_PESSOAIS: Int?
    let ACIDENTES_PESSOAIS_DN: Int?
    let GAP_TOTAL_GRUPO: Int?
    let GARANTIA_EST_MECANICA_TOT_TOTAL: Int?
    let GARANTIA_ESTENDIDA_CLP_TOTAL: Int?
    let GAR_ESTENDIDA_CLP_FIN_TOTAL: Int?
    let GAR_ESTENDIDA_CLP_AVI_TOTAL: Int?
    let GARANTIA_ESTENDIDA_VW_TOTAL: Int?
    let GARANTIA_ESTENDIDA_VW_FIN_TOTAL: Int?
    let GARANTIA_ESTENDIDA_VW_AVI_TOTAL: Int?
    let GE_VW_ESSENCIAL12_TOTAL: Int?
    let GE_VW_ESSENCIAL24_TOTAL: Int?
    let GE_VW_TOTAL12_TOTAL: Int?
    let GE_VW_TOTAL24_TOTAL: Int?
    let GE_VW_ESSEN_MODELO_12_TOTAL: Int?
    let GE_VW_ESSEN_MODELO_24_TOTAL: Int?
    let GE_VW_ESSEN_MODELO_36_TOTAL: Int?
    let GE_VW_ESSEN_MODELO_48_TOTAL: Int?
    let GE_VW_TOTAL_MODELO_12_TOTAL: Int?
    
}

struct AcidentesPessoais: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "ACIDENTES_PESSOAIS_DN"
    }
}

struct Franquia: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "FRANQUIA_DN"
    }
}

struct Gap: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GAP_DN"
    }
}

struct GarantiaEstMecanicaTot: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GARANTIA_EST_MECANICA_TOT_Entity_DN"
    }
}

struct GarantiaEstEndIDACLP: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GARANTIA_ESTENDIDA_CLP_DN"
    }
}

struct GarantiaEstClpFin: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GAR_ESTENDIDA_CLP_FIN_DN"
    }
}

struct GarantiaEstClpAvi: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GAR_ESTENDIDA_CLP_AVI_DN"
    }
}

struct GarantiaEstendidaVw: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GARANTIA_ESTENDIDA_VW_DN"
    }
}

struct GarantiaEstendidaVwFin: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GAR_ESTENDIDA_VW_FIN_DN"
    }
}

struct GarantiaEstendidaVwAvi: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GAR_ESTENDIDA_VW_AVI_DN"
    }
}

struct GEVwEssencial12: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GE_VW_ESSENCIAL12_DN"
    }
}

struct GEVwEssencial24: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GE_VW_ESSENCIAL24_DN"
    }
}

struct GEVWEssenModelo12: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GE_VW_ESSEN_MODELO_12_DN"
    }
}

struct GEVWEssenModelo24: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GE_VW_ESSEN_MODELO_24_DN"
    }
}

struct GEVWEssenModelo36: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GE_VW_ESSEN_MODELO_36_DN"
    }
}

struct GEVWEssenModelo48: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GE_VW_ESSEN_MODELO_48_DN"
    }
}

struct GEVWTotalModelo12: Codable {
    let cdDn: Int?
    let valor: Int?
    
    enum CodingKeys: String, CodingKey {
        case cdDn = "CD_DN"
        case valor = "GGE_VW_TOTAL_MODELO_12_DN"
    }
}
