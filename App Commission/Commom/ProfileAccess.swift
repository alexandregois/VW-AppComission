//
//  ProfileAccess.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 16/06/23.
//

import Foundation

class ProfileAccess {
    static let shared = ProfileAccess()
    
    var profile: UserProfile = .lop
    var funcs = [String]()
    
    func setUserProfile(role: String){
        if role == "TPO-STA-GES-LOP" {
            profile = .lop
        } else if role == "TPO-STA-GES-LOF" {
            profile = .lof
        } else if role == "TPO-STA-GES-GOP" {
            profile = .gop
        } else if role == "TPO-STA-GES-GOF" {
            profile = .gof
        } else if role == "TPO-STA-GES-REL" {
            profile = .rel
        } else {
            profile = .lop
        }
            
    }
    
    func userAccess(prof: UserProfile) {
        
        switch profile {
        case .lop:
            funcs = [String] ()
            funcs.append("NOTICIAS")
            funcs.append("DESEMPENHO")
            funcs.append("DESEMPENHO-PERFORMANCE")
            funcs.append("DESEMPENHO-PERFORMANCE-PERIODO-VIGENTE")
            funcs.append("DESEMPENHO-PERFORMANCE-HISTORICO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-FINANCIAMENTO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-PRODUTOS-AGREGADOS")
            funcs.append("PERIODOS")
        case .lof:
            funcs = [String] ()
            funcs.append("NOTICIAS")
            funcs.append("DESEMPENHO")
            funcs.append("DESEMPENHO-INDICES")
            funcs.append("DESEMPENHO-INDICES-VIGENTE")
            funcs.append("DESEMPENHO-PERFORMANCE")
            funcs.append("DESEMPENHO-PERFORMANCE-PERIODO-VIGENTE")
            funcs.append("DESEMPENHO-PERFORMANCE-HISTORICO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-FINANCIAMENTO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-PRODUTOS-AGREGADOS")
            funcs.append("PERIODOS")
        case .gop:
            funcs = [String] ()
            funcs.append("NOTICIAS")
            funcs.append("DESEMPENHO")
            funcs.append("DESEMPENHO-PERFORMANCE")
            funcs.append("DESEMPENHO-PERFORMANCE-PERIODO-VIGENTE")
            funcs.append("DESEMPENHO-PERFORMANCE-HISTORICO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-FINANCIAMENTO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-PRODUTOS-AGREGADOS")
            funcs.append("SIMULADOR")
            funcs.append("PERIODOS")
        case .gof:
            funcs = [String] ()
            funcs.append("NOTICIAS")
            funcs.append("DESEMPENHO")
            funcs.append("DESEMPENHO-INDICES")
            funcs.append("DESEMPENHO-INDICES-VIGENTE")
            funcs.append("DESEMPENHO-INDICES-PERFORMADO")
            funcs.append("DESEMPENHO-INDICES-HISTORICO")
            funcs.append("DESEMPENHO-PERFORMANCE")
            funcs.append("DESEMPENHO-PERFORMANCE-PERIODO-VIGENTE")
            funcs.append("DESEMPENHO-PERFORMANCE-HISTORICO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-FINANCIAMENTO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-PRODUTOS-AGREGADOS")
            funcs.append("SIMULADOR")
            funcs.append("PERIODOS")
        case .rel:
            funcs = [String] ()
            funcs.append("NOTICIAS")
            funcs.append("DESEMPENHO")
            funcs.append("DESEMPENHO-INDICES")
            funcs.append("DESEMPENHO-INDICES-VIGENTE")
            funcs.append("DESEMPENHO-INDICES-PERFORMADO")
            funcs.append("DESEMPENHO-INDICES-HISTORICO")
            funcs.append("DESEMPENHO-PERFORMANCE")
            funcs.append("DESEMPENHO-PERFORMANCE-PERIODO-VIGENTE")
            funcs.append("DESEMPENHO-PERFORMANCE-HISTORICO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-FINANCIAMENTO")
            funcs.append("DESEMPENHO-PERFORMANCE-VOLUMES-PRODUTOS-AGREGADOS")
            funcs.append("SIMULADOR")
            funcs.append("PERIODOS")
            funcs.append("ADMIN")
        }
        
    }
}
