//
//  SimuladorRealizado.swift
//  App Commission
//
//  Created by Alexandre Gois on 12/07/23.
//

import Foundation

struct SimulatorRealizado : Codable {
        
    let GRUPO: String?
    let AAK: Double?
    let VOLUMES_NOVOS: Double?
    let PENETRATION: Double?
    let ISR: Double?
    let VOLUMES_USADOS: Double?
    let INDICE_PERFORMADO: Double?
    let MIX_TABELA: Double?
    
    init() {
            self.GRUPO = nil
            self.AAK = nil
            self.VOLUMES_NOVOS = nil
            self.PENETRATION = nil
            self.ISR = nil
            self.VOLUMES_USADOS = nil
            self.INDICE_PERFORMADO = nil
            self.MIX_TABELA = nil
        }
    
    
}
