//
//  Notification.swift
//  App Commission
//
//  Created by Alexandre Gois on 24/07/23.
//

import Foundation

struct Notificacao : Codable {
    
    let ID_COMUNICADO: Int?
    let NM_COMUNICADO: String?
    let DS_COMUNICADO: String?
    let ID_IMG_COMUNICADO: Int?
    let TP_RECEBEDORES_COMUNICADO: Int?
    let TP_COMUNICADO: String?
    let DT_COMUNICADO: String?
    let ST_ATIVO_COMUNICADO: String?
    
    init() {
        
        self.ID_COMUNICADO = nil
        self.NM_COMUNICADO = nil
        self.DS_COMUNICADO = nil
        self.ID_IMG_COMUNICADO = nil
        self.TP_RECEBEDORES_COMUNICADO = nil
        self.TP_COMUNICADO = nil
        self.DT_COMUNICADO = nil
        self.ST_ATIVO_COMUNICADO = nil
        
        }
    
}
