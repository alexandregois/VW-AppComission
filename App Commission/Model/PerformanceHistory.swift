//
//  PerformanceHistory.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 17/07/23.
//

import Foundation

struct PerformanceHistory: Codable {
    let isr: String
    let penetration: String
    let periodo: String
    
    enum CodingKeys: String, CodingKey {
        case isr = "ISR"
        case penetration = "PENETRATION"
        case periodo = "PERIODO"
    }
    
    init(isr: String, penetration: String, periodo: String) {
        
        self.periodo = periodo
        self.isr = isr
        self.penetration = penetration
        
    }
}

