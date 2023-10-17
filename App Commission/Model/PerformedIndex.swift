//
//  PerformedIndex.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 11/07/23.
//

import Foundation

struct PerformedIndex: Codable {
    
    let tabelaCompleta: TableData
    let tabelaResumida: TableData
    
    enum CodingKeys: String, CodingKey {
        case tabelaCompleta = "TABELA_COMPLETA"
        case tabelaResumida = "TABELA_RESUMIDA"
    }
    
    init(tabelaCompleta: TableData, tabelaResumida: TableData) {
        self.tabelaCompleta = tabelaCompleta
        self.tabelaResumida = tabelaResumida
    }
}

