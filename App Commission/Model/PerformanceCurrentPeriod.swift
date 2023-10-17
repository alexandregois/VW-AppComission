//
//  PerformanceCurrentPeriod.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 10/07/23.
//

import Foundation

struct PerformanceCurrentPeriod: Codable {
    
    let periodoAtual: CurrentPeriod
    let periodoAnterior: CurrentPeriod
    
    enum CodingKeys: String, CodingKey {
        case periodoAtual = "PERIODO_ATUAL"
        case periodoAnterior = "PERIODO_ANTERIOR"
    }
    
    init(periodoAtual: CurrentPeriod, periodoAnterior: CurrentPeriod) {
        
        self.periodoAtual = periodoAtual
        self.periodoAnterior = periodoAnterior
    }
}


struct PerformanceCurrentPeriod2: Codable {
    
    let periodoAtual: CurrentPeriod
    let periodoAnterior: CurrentPeriod
    
    enum CodingKeys: String, CodingKey {
        case periodoAtual = "PERIODO_ATUAL"
        case periodoAnterior = "PERIODO_ANTERIOR"
    }
    
    init(periodoAtual: CurrentPeriod, periodoAnterior: CurrentPeriod) {
        
        self.periodoAtual = periodoAtual
        self.periodoAnterior = periodoAnterior
    }
}
