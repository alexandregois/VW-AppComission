//
//  PeriodosVolume.swift
//  App Commission
//
//  Created by Alexandre Gois on 09/08/23.
//

import Foundation

struct PeriodosVolumeModel: Codable {
    let listMeses: [Int]
    let periodoAtual: Int
    
    enum CodingKeys: String, CodingKey {
        case listMeses = "ListMeses"
        case periodoAtual = "PeriodoAtual"
    }
    
    init(listMeses: [Int], periodoAtual: Int) {
        self.listMeses = listMeses
        self.periodoAtual = periodoAtual
    }
}
