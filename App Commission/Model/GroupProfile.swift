//
//  GroupProfile.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 26/06/23.
//

import Foundation


struct GroupProfile : Codable {
    
    let groupComission: String?
    let dealers: [Dealer]
    
    enum CodingKeys: String, CodingKey {
        case groupComission = "GRUPO_COMISSION"
        case dealers = "DEALERS"
    }
    
    init(groupComission: String, dealers: [Dealer]) {
        
        self.groupComission = groupComission
        self.dealers = dealers
    }
}
