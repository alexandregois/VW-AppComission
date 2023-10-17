//
//  SimulatorProjection.swift
//  App Commission
//
//  Created by Alexandre Gois on 12/07/23.
//

import Foundation

struct SimulatorProjection : Codable {
    
    let PENETRATION_VAREJO: Double?
    let ISR_VAREJO: Double?
    let VOLUMES_NOVOS: Double?
    let VOLUMES_USADOS: Double?
    let PONTOS_POR_CONTRATO: Double?
    let INDICE_PERFORMADO: Double?
    let INDICE_PROJETADO: Double?
    let VARIACAO_INDICE: Double?
    let MIX_TABELA: Double?
    let VALOR_MEDIO_FIN: Double?
    let COMISSAO_MEDIA_MES: Double?
    let COMISSAO_PROJETADA: Double?
    let VARIACAO_COMMISSIONAL_MENSAL: Double?
    
    init() {
        
        self.PENETRATION_VAREJO = nil
        self.ISR_VAREJO = nil
        self.VOLUMES_NOVOS = nil
        self.VOLUMES_USADOS = nil
        self.PONTOS_POR_CONTRATO = nil
        self.INDICE_PERFORMADO = nil
        self.INDICE_PROJETADO = nil
        self.VARIACAO_INDICE = nil
        self.MIX_TABELA = nil
        self.VALOR_MEDIO_FIN = nil
        self.COMISSAO_MEDIA_MES = nil
        self.COMISSAO_PROJETADA = nil
        self.VARIACAO_COMMISSIONAL_MENSAL = nil
        
        }
    
}
