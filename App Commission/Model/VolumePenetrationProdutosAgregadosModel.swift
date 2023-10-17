//
//  VolumePenetrationProdutosAgregadosModel.swift
//  App Commission
//
//  Created by Alexandre Gois on 14/08/23.
//

import Foundation

struct VolumePenetrationProdutosAgregadosModel: Codable {
    let garantiaExtendidaList: GarantiaExtendidaList?
    let ppsList: PPSList?
    let seguroCascoList: SeguroCascoList?
    let spfList: SPFList?
    let cdDn: Int?
    let grupo: String?
    let nrExercicio: Int?
    let tpSegmento: String?
    let acidentesPessoais: Int?
    let franquia: Int?
    let gap: Int?
    let garantiaExtendida: Int?
    let pps: Int?
    let seguroCasco: Int?
    let spf: Int?
    
    enum CodingKeys: String, CodingKey {
        case garantiaExtendidaList = "GARANTIA_EXTENDIDA_LIST"
        case ppsList = "PPS_LIST"
        case seguroCascoList = "SEGURO_CASCO_LIST"
        case spfList = "SPF_LIST"
        case cdDn = "CD_DN"
        case grupo = "GRUPO"
        case nrExercicio = "NR_EXERCICIO"
        case tpSegmento = "TP_SEGMENTO"
        case acidentesPessoais = "ACIDENTES_PESSOAIS"
        case franquia = "FRANQUIA"
        case gap = "GAP"
        case garantiaExtendida = "GARANTIA_EXTENDIDA"
        case pps = "PPS"
        case seguroCasco = "SEGURO_CASCO"
        case spf = "SPF"
    }
}

struct GarantiaExtendidaList: Codable {
    let garantiaEstendidaClp: Int?
    let garEstendidaClpFin: Int?
    let garEstendidaClpAvi: Int?
    let garantiaEstendidaVw: Int?
    let garEstendidaVwFin: Int?
    let garEstendidaVwAvi: Int?
    let geVwEssencial12: Int?
    let geVwEssencial24: Int?
    let geVwTotal12: Int?
    let geVwTotal24: Int?
    let geVwEssenModelo12: Int?
    let geVwEssenModelo24: Int?
    let geVwEssenModelo36: Int?
    let geVwEssenModelo48: Int?
    let geVwTotalModelo12: Int?
    let geVwTotalModelo24: Int?
    let geVwTotalModelo36: Int?
    let geVwTotalModelo48: Int?
    let aapGe: Int?
    let geEvr: Int?
    let geVwEssenVi12: Int?
    let geVwEssenVi24: Int?
    let geVwEssenVi36: Int?
    let geVwEssenVi48: Int?
    let geVwEssenModVi12: Int?
    let geVwEssenModVi24: Int?
    let geVwEssenModVi36: Int?
    let geVwEssenModVi48: Int?
    let geVwTotalVi12: Int?
    let geVwTotalVi24: Int?
    let geVwTotalVi36: Int?
    let geVwTotalVi48: Int?
    let geVwTotalModVi12: Int?
    let geVwTotalModVi24: Int?
    let geVwTotalModVi36: Int?
    let geVwTotalModVi48: Int?
    let geVwTotal6: Int?
    let geVwEssencial6: Int?
    let garantiaMecanicaAAP: Int?
    let garantiaMecanicaSNC: Int?
    let garantiaMecanicaGM: Int?
    let garantiaMecanicaGM6: Int?
    let gmEssencial12: Int?
    let gmEssencial24: Int?
    let gmTop12: Int?
    let gmTop24: Int?
    let aapGm: Int?
    let gmEssencial6: Int?
    let gmTop6: Int?
    
    enum CodingKeys: String, CodingKey {
        case garantiaEstendidaClp = "GARANTIA_ESTENDIDA_CLP"
        case garEstendidaClpFin = "GAR_ESTENDIDA_CLP_FIN"
        case garEstendidaClpAvi = "GAR_ESTENDIDA_CLP_AVI"
        case garantiaEstendidaVw = "GARANTIA_ESTENDIDA_VW"
        case garEstendidaVwFin = "GAR_ESTENDIDA_VW_FIN"
        case garEstendidaVwAvi = "GAR_ESTENDIDA_VW_AVI"
        case geVwEssencial12 = "GE_VW_ESSENCIAL12"
        case geVwEssencial24 = "GE_VW_ESSENCIAL24"
        case geVwTotal12 = "GE_VW_TOTAL12"
        case geVwTotal24 = "GE_VW_TOTAL24"
        case geVwEssenModelo12 = "GE_VW_ESSEN_MODELO12"
        case geVwEssenModelo24 = "GE_VW_ESSEN_MODELO24"
        case geVwEssenModelo36 = "GE_VW_ESSEN_MODELO36"
        case geVwEssenModelo48 = "GE_VW_ESSEN_MODELO48"
        case geVwTotalModelo12 = "GE_VW_TOTAL_MODELO12"
        case geVwTotalModelo24 = "GE_VW_TOTAL_MODELO24"
        case geVwTotalModelo36 = "GE_VW_TOTAL_MODELO36"
        case geVwTotalModelo48 = "GE_VW_TOTAL_MODELO48"
        case aapGe = "AAP_GE"
        case geEvr = "GE_EVR"
        case geVwEssenVi12 = "GE_VW_ESSEN_VI12"
        case geVwEssenVi24 = "GE_VW_ESSEN_VI24"
        case geVwEssenVi36 = "GE_VW_ESSEN_VI36"
        case geVwEssenVi48 = "GE_VW_ESSEN_VI48"
        case geVwEssenModVi12 = "GE_VW_ESSEN_MOD_VI12"
        case geVwEssenModVi24 = "GE_VW_ESSEN_MOD_VI24"
        case geVwEssenModVi36 = "GE_VW_ESSEN_MOD_VI36"
        case geVwEssenModVi48 = "GE_VW_ESSEN_MOD_VI48"
        case geVwTotalVi12 = "GE_VW_TOTAL_VI12"
        case geVwTotalVi24 = "GE_VW_TOTAL_VI24"
        case geVwTotalVi36 = "GE_VW_TOTAL_VI36"
        case geVwTotalVi48 = "GE_VW_TOTAL_VI48"
        case geVwTotalModVi12 = "GE_VW_TOTAL_MOD_VI12"
        case geVwTotalModVi24 = "GE_VW_TOTAL_MOD_VI24"
        case geVwTotalModVi36 = "GE_VW_TOTAL_MOD_VI36"
        case geVwTotalModVi48 = "GE_VW_TOTAL_MOD_VI48"
        case geVwTotal6 = "GE_VW_TOTAL6"
        case geVwEssencial6 = "GE_VW_ESSENCIAL6"
        case garantiaMecanicaAAP = "GARANTIA_MECANICA_AAP"
        case garantiaMecanicaSNC = "GARANTIA_MECANICA_SNC"
        case garantiaMecanicaGM = "GARANTIA_MECANICA_GM"
        case garantiaMecanicaGM6 = "GARANTIA_MECANICA_GM6"
        case gmEssencial12 = "GM_ESSENCIAL12"
        case gmEssencial24 = "GM_ESSENCIAL24"
        case gmTop12 = "GM_TOP12"
        case gmTop24 = "GM_TOP24"
        case aapGm = "AAP_GM"
        case gmEssencial6 = "GM_ESSENCIAL6"
        case gmTop6 = "GM_TOP6"
    }
}

struct PPSList: Codable {
    let ppsAVista: Int?
    let ppsFinanciado: Int?
    let ppsAVistaVendaInternet: Int?
    
    enum CodingKeys: String, CodingKey {
        case ppsAVista = "PPS_A_VISTA"
        case ppsFinanciado = "PPS_FINANCIADO"
        case ppsAVistaVendaInternet = "PPS_A_VISTA_VENDA_INTERNET"
    }
}

struct SeguroCascoList: Codable {
    let segCascoVarejoFX1: Int?
    let segCascoVarejoFX2: Int?
    let segCascoFrota: Int?
    let segPluri24FX1: Int?
    let segPluri24FX2: Int?
    let segPluri36FX1: Int?
    let segPluri36FX2: Int?
    let segDescMaior: Int?
    let segPortoSeguroCasco: Int?
    let segCascoDupl: Int?
    let segCascoVarVi12: Int?
    let segCascoVarVi24: Int?
    let segCascoVarVi36: Int?
    let segCascoVarVi48: Int?
    let seguroRf: Int?
    
    enum CodingKeys: String, CodingKey {
        case segCascoVarejoFX1 = "SEG_CASCO_VAREJO_FX1"
        case segCascoVarejoFX2 = "SEG_CASCO_VAREJO_FX2"
        case segCascoFrota = "SEG_CASCO_FROTA"
        case segPluri24FX1 = "SEG_PLURI_24_FX1"
        case segPluri24FX2 = "SEG_PLURI_24_FX2"
        case segPluri36FX1 = "SEG_PLURI_36_FX1"
        case segPluri36FX2 = "SEG_PLURI_36_FX2"
        case segDescMaior = "SEG_DESC_MAIOR"
        case segPortoSeguroCasco = "SEG_PORTO_SEGURO_CASCO"
        case segCascoDupl = "SEG_CASCO_DUPL"
        case segCascoVarVi12 = "SEG_CASCO_VAR_VI_12"
        case segCascoVarVi24 = "SEG_CASCO_VAR_VI_24"
        case segCascoVarVi36 = "SEG_CASCO_VAR_VI_36"
        case segCascoVarVi48 = "SEG_CASCO_VAR_VI_48"
        case seguroRf = "SEGURO_RF"
    }
}

struct SPFList: Codable {
    let spfPlus: Int?
    let spfNormal: Int?
    let spfBasico: Int?
    
    enum CodingKeys: String, CodingKey {
        case spfPlus = "SPF_PLUS"
        case spfNormal = "SPF_NORMAL"
        case spfBasico = "SPF_BASICO"
    }
}

