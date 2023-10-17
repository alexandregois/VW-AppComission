//
//  VolumePenetrationModel.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 01/08/23.
//

import Foundation

//Model de tela
struct VolumePenetrationModel {
    
    var segmento: String?
    var nrExercicio: Int?
    var visaoAcumulada: Bool?
    var cdDn: Int?
    var grupo: String?
    var nrGrupo: Float?
    var listCdDn: [VolumePenetrationCdDn]?
}

struct VolumePenetrationCdDn {
    var cdDn: Int?
    //var valueCdDn: Int?
    var valueCdDn: Float? // Por causa do GetPenetrationGrupo onde PENETRATION_CD_DN é Float
    
}
