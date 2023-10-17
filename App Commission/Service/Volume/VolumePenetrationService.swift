//
//  PerformanceVolumeService.swift
//  App Commission
//
//  Created by Alexandre Gois on 02/08/23.
//

import Foundation

class VolumePenetrationService {
    
    static let shared = VolumePenetrationService()
    
    let defaults = UserDefaults.standard
    //let grantType = "password"
    
    //getVolumePenetrationVeiculosUsados
    func getVolumePenetrationVeiculosUsados(isFrota: Bool, acumulado: Bool, actualPeriod: String?, _ completion: @escaping (VolumePenetrationModel?, Error?) -> Void) {
        
        var actualPeriodValue = actualPeriod
            if actualPeriodValue == nil || actualPeriodValue!.isEmpty {
                actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
            }
        let currentUser = User.getGlobal()
        let segmento = isFrota ? "FROTA" : "VAREJO"
        
        let performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumePenetrationVeiculosUsados!))\(segmento)/\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriodValue!))?acumulado=\(acumulado)"
        
        NetworkCall(data: nil, url: performanceUrl, service: nil, method: .get).executeQuery(){
            (result: Result<VolumePenetrationVeiculosUsadosModel,Error>) in
            switch result{
            case .success(let performance):
                var listCdDn: [VolumePenetrationCdDn] = []
                for item in performance.listaCdDn {
                    if let finVeiculosUsadosCdDn = item.finVeiculosUsadosCdDn {
                        let cdDnItem = VolumePenetrationCdDn(cdDn: item.cdDn, valueCdDn: Float(finVeiculosUsadosCdDn))
                        listCdDn.append(cdDnItem)
                    }
                }
                let penetrationModel = VolumePenetrationModel(segmento: performance.segmento,
                                                              nrExercicio: performance.nrExercicio,
                                                              visaoAcumulada: performance.visaoAcumulada,
                                                              cdDn: performance.cdDn,
                                                              grupo: performance.grupo,
                                                              nrGrupo: Float(performance.finVeiculosUsadosGrupo ?? 0),
                                                              listCdDn: listCdDn)

                completion(penetrationModel, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    //getVolumePenetrationVeiculosNovos
    func getVolumePenetrationVeiculosNovos(isFrota: Bool, acumulado: Bool, actualPeriod: String?, _ completion: @escaping (VolumePenetrationModel?, Error?) -> Void) {
        
        var actualPeriodValue = actualPeriod
            if actualPeriodValue == nil || actualPeriodValue!.isEmpty {
                actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
            }
        let currentUser = User.getGlobal()
        let segmento = isFrota ? "FROTA" : "VAREJO"
        
        let performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumePenetrationVeiculosNovos!))\(segmento)/\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriodValue!))?acumulado=\(acumulado)"
        
        NetworkCall(data: nil, url: performanceUrl, service: nil, method: .get).executeQuery(){
            (result: Result<VolumePenetrationVeiculosNovosModel,Error>) in
            switch result{
            case .success(let performance):
                var listCdDn: [VolumePenetrationCdDn] = []
                for item in performance.listaCdDn {
                    if let finVeiculosNovosCdDn = item.finVeiculosNovosCdDn {
                        let cdDnItem = VolumePenetrationCdDn(cdDn: item.cdDn, valueCdDn: Float(finVeiculosNovosCdDn))
                        listCdDn.append(cdDnItem)
                    }
                }
                let penetrationModel = VolumePenetrationModel(segmento: performance.segmento,
                                                              nrExercicio: performance.nrExercicio,
                                                              visaoAcumulada: performance.visaoAcumulada,
                                                              cdDn: performance.cdDn,
                                                              grupo: performance.grupo,
                                                              nrGrupo: Float(performance.finVeiculosNovosGrupo ?? 0),
                                                              listCdDn: listCdDn)

                completion(penetrationModel, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    //getVolumePenetrationConsorcio
    func getVolumePenetrationConsorcio(isFrota: Bool, acumulado: Bool, actualPeriod: String?, _ completion: @escaping (VolumePenetrationModel?, Error?) -> Void) {
        
        var actualPeriodValue = actualPeriod
            if actualPeriodValue == nil || actualPeriodValue!.isEmpty {
                actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
            }
        let currentUser = User.getGlobal()
        let segmento = isFrota ? "FROTA" : "VAREJO"
        
        let performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumePenetrationConsorcio!))\(segmento)/\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriodValue!))?acumulado=\(acumulado)"
        
        NetworkCall(data: nil, url: performanceUrl, service: nil, method: .get).executeQuery(){
            (result: Result<VolumePenetrationConsorcioModel,Error>) in
            switch result{
            case .success(let performance):
                var listCdDn: [VolumePenetrationCdDn] = []
                for item in performance.listaCdDn {
                    if let consorcioCdDn = item.consorcioCdDn {
                        let cdDnItem = VolumePenetrationCdDn(cdDn: item.cdDn, valueCdDn: Float(consorcioCdDn))
                        listCdDn.append(cdDnItem)
                    }
                }
                let penetrationModel = VolumePenetrationModel(segmento: performance.segmento,
                                                              nrExercicio: performance.nrExercicio,
                                                              visaoAcumulada: performance.visaoAcumulada,
                                                              cdDn: performance.cdDn,
                                                              grupo: performance.grupo,
                                                              nrGrupo: Float(performance.consorcioGrupo ?? 0),
                                                              listCdDn: listCdDn)
                completion(penetrationModel, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    //getVolumePenetration
    func getVolumePenetration(isFrota: Bool, acumulado: Bool, actualPeriod: String?, _ completion: @escaping (VolumePenetrationModel?, Error?) -> Void) {
        
        var actualPeriodValue = actualPeriod
            if actualPeriodValue == nil || actualPeriodValue!.isEmpty {
                actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
            }
        let currentUser = User.getGlobal()
        let segmento = isFrota ? "FROTA" : "VAREJO"
        
        let performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumePenetration!))\(segmento)/\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriodValue!))?acumulado=\(acumulado)"
        
        NetworkCall(data: nil, url: performanceUrl, service: nil, method: .get).executeQuery(){
            (result: Result<VolumePenetrationPenetrationModel,Error>) in
            switch result{
            case .success(let performance):
                var listCdDn: [VolumePenetrationCdDn] = []
                for item in performance.listaCdDn {
                    let cdDnItem = VolumePenetrationCdDn(cdDn: item.cdDn, valueCdDn: item.penetrationCdDn)
                    listCdDn.append(cdDnItem)
                }
                let penetrationModel = VolumePenetrationModel(segmento: performance.segmento,
                                                              nrExercicio: performance.nrExercicio,
                                                              visaoAcumulada: performance.visaoAcumulada,
                                                              cdDn: performance.cdDn,
                                                              grupo: performance.grupo,
                                                              nrGrupo: performance.penetrationGrupo,
                                                              listCdDn: listCdDn)
                completion(penetrationModel, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    //getVolumePenetrationAak
    func getVolumePenetrationAak(isFrota: Bool, acumulado: Bool, actualPeriod: String?, _ completion: @escaping (VolumePenetrationModel?, Error?) -> Void) {
        
        var actualPeriodValue = actualPeriod
            if actualPeriodValue == nil || actualPeriodValue!.isEmpty {
                actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
            }
        
        let currentUser = User.getGlobal()
        let segmento = isFrota ? "FROTA" : "VAREJO"
        
        let performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumePenetrationAak!))\(segmento)/\(String(describing: currentUser!.codigoDealer!))/\(actualPeriodValue!)?acumulado=\(acumulado)"
        
        NetworkCall(data: nil, url: performanceUrl, service: nil, method: .get).executeQuery(){
            (result: Result<VolumePenetrationAAKModel,Error>) in
            switch result{
            case .success(let performance):
                var listCdDn: [VolumePenetrationCdDn] = []
                for item in performance.listaCdDn {
                    if let aakCdDn = item.aakCdDn {
                        let cdDnItem = VolumePenetrationCdDn(cdDn: item.cdDn, valueCdDn: Float(aakCdDn))
                        listCdDn.append(cdDnItem)
                    }
                }
                let penetrationModel = VolumePenetrationModel(segmento: performance.segmento,
                                                              nrExercicio: performance.nrExercicio,
                                                              visaoAcumulada: performance.visaoAcumulada,
                                                              cdDn: performance.cdDn,
                                                              grupo: performance.grupo,
                                                              nrGrupo: Float(performance.aakGrupo ?? 0),
                                                              listCdDn: listCdDn)
                completion(penetrationModel, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    //getVolumePenetrationIsrGrupo
    func getVolumePenetrationIsrGrupo(isFrota: Bool, acumulado: Bool, actualPeriod: String?, _ completion: @escaping (VolumePenetrationModel?, Error?) -> Void) {
        
        var actualPeriodValue = actualPeriod
            if actualPeriodValue == nil || actualPeriodValue!.isEmpty {
                actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
            }
        let currentUser = User.getGlobal()
        let segmento = isFrota ? "FROTA" : "VAREJO"
        
        let performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumePenetrationIsrGrupo!))\(segmento)/\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriodValue!))?acumulado=\(acumulado)"
        
        NetworkCall(data: nil, url: performanceUrl, service: nil, method: .get).executeQuery(){
            (result: Result<VolumePenetrationISRModel,Error>) in
            switch result{
            case .success(let performance):
                var listCdDn: [VolumePenetrationCdDn] = []
                for item in performance.listaCdDn {
                    let cdDnItem = VolumePenetrationCdDn(cdDn: item.cdDn, valueCdDn: item.valueCdDn)
                    listCdDn.append(cdDnItem)
                }
                let penetrationModel = VolumePenetrationModel(segmento: performance.segmento,
                                                              nrExercicio: performance.nrExercicio,
                                                              visaoAcumulada: performance.visaoAcumulada,
                                                              cdDn: performance.cdDn,
                                                              grupo: performance.grupo,
                                                              nrGrupo: performance.isrGrupo,
                                                              listCdDn: listCdDn)
                completion(penetrationModel, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    //getVolumeProdutosAgregados
    func getVolumeProdutosAgregados(isFrota: Bool, actualPeriod: String?, nm_grp_comission: String?, cd_dn: String?, _ completion: @escaping (VolumePenetrationProdutosAgregadosModel?, Error?) -> Void) {
            
        var actualPeriodValue = actualPeriod
        if actualPeriodValue == nil || actualPeriodValue!.isEmpty {
            actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        }
        
        let currentUser = User.getGlobal()
        let segmento = isFrota ? "FROTA" : "VAREJO"
        
        var performanceUrl = ""
        
        
//        if nm_grp_comission == cd_dn, let nmGrpComissionValue = nm_grp_comission, !nmGrpComissionValue.isEmpty {
//            performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumeProdutosAgregados!))\(segmento)/\(String(describing: actualPeriodValue!))?nm_grp_comission=\(nmGrpComissionValue)"
        
        if nm_grp_comission == cd_dn, let nmGrpComissionValue = nm_grp_comission, !nmGrpComissionValue.isEmpty {
            performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumeProdutosAgregados!))\(segmento)/\(String(describing: actualPeriodValue!))?nm_grp_comission=\(nmGrpComissionValue)"
        } else if let cdDnValue = cd_dn, !cdDnValue.isEmpty {
            performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumeProdutosAgregados!))\(segmento)/\(String(describing: actualPeriodValue!))?cd_dn=\(cdDnValue)"
        } else {
            performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumeProdutosAgregados!))\(segmento)/\(String(describing: actualPeriodValue!))?cd_dn=\(String(describing: currentUser!.codigoDealer!))"
        }
        
        NetworkCall(data: nil, url: performanceUrl, service: nil, method: .get).executeQuery() { (result: Result<VolumePenetrationProdutosAgregadosModel,Error>) in
            switch result {
            case .success(let performance):
                completion(performance, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    
    func getPeriodosVolumePenetration(_ completion: @escaping (PeriodosVolumeModel?, Error?) -> Void) {
        
        let periodsUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getPeriodosVolumePenetration!))"
        
        NetworkCall(data: nil, url: periodsUrl, service: nil, method: .get).executeQuery(){
            (result: Result<PeriodosVolumeModel,Error>) in
            switch result{
            case .success(let periods):
                completion(periods, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getListaDnGrupo(actualPeriod: String?, codigoDealer: String?, _ completion: @escaping (ProdutosAgregadosDnModel?, Error?) -> Void) {
        
        let currentUser = User.getGlobal()
        
        var actualPeriodValue = actualPeriod
        if actualPeriodValue == nil || actualPeriodValue!.isEmpty {
            actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        }
        
        var actualCodigoDealer = codigoDealer
        if actualCodigoDealer == nil || actualCodigoDealer!.isEmpty {
            actualCodigoDealer = currentUser!.codigoDealer!
        }
        
        let grupoDnUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getListaDnGrupo!))/\(String(describing: currentUser!.codigoDealer!))/\(String(describing: actualPeriodValue!))"
        
        NetworkCall(data: nil, url: grupoDnUrl, service: nil, method: .get).executeQuery(){
            (result: Result<ProdutosAgregadosDnModel,Error>) in
            switch result{
            case .success(let periods):
                completion(periods, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getVolumeProdutosAgregadosListaCdDn(isFrota: Bool, type: String, _ completion: @escaping (VolumePenetrationProdutosAgregadosListaCdDnModel?, Error?) -> Void) {
            
        let actualPeriodValue = defaults.string(forKey: SystemKeys.ACTUAL_PERIOD)
        
        let currentUser = User.getGlobal()
        let segmento = isFrota ? "FROTA" : "VAREJO"
        
        let performanceUrl = "\(String(describing: Urls.shared.baseUrl!))\(String(describing: Urls.shared.getVolumeProdutosAgregadosListaCdDn!))\(actualPeriodValue!)/\(segmento)?\(type)"
        
        NetworkCall(data: nil, url: performanceUrl, service: nil, method: .get).executeQuery() { (result: Result<VolumePenetrationProdutosAgregadosListaCdDnModel,Error>) in
            switch result {
            case .success(let performance):
                completion(performance, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    
}

