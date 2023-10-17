//
//  Urls.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 15/06/23.
//

import Foundation

class Urls {
    
    static let shared = Urls()
    
    var environment: Environment = .production
    //var environment: Environment = .development
    var keyCloakClientId:String = ""
    var keyclokClientSecret:String = ""
    var grantType:String = ""
    var keyclockUrl:String = ""
    var baseUrl :String! = ""
    var getNews: String! = ""
    var getPeriod: String! = ""
    var clientId:String = ""
    var clientSecret:String = ""
    var imgBaseUrl: String = ""
    var getDealers: String! = ""
    var getGroups: String! = ""
    var getGroupProfile: String! = ""
    var getActualPeriod: String! = ""
    var getDataCarga: String! = ""
    var getIndiceVigenteVarejo: String! = ""
    var getIndiceVigenteFrota: String! = ""
    var getSimulatorRealizado: String! = ""
    var postSimuladorProjection: String! = ""
    var getPeriodoVigenteVarejo: String! = ""
    var getPeriodoVigenteFrota: String! = ""
    var getPerformedIndexVarejo: String! = ""
    var getPerformedIndexFrota: String! = ""
    var getPerformedIndexAcelera: String! = ""
    var getHistoryIndexVarejo: String! = ""
    var getHistoryIndexFrota: String! = ""
    var getIndiceAceleraVarejo: String! = ""
    var getIndiceAceleraFrota: String! = ""
    var getNotifications: String! = ""
    var getVolumePenetrationVeiculosUsados: String! = ""
    var getVolumePenetrationVeiculosNovos: String! = ""
    var getVolumePenetrationConsorcio: String! = ""
    var getVolumePenetration: String! = ""
    var getVolumePenetrationAak: String! = ""
    var getPeriodosVolumePenetration: String! = ""
    
    var getVolumePenetrationIsrGrupo: String! = ""
    var getVolumeProdutosAgregados: String! = ""
    var getVolumeProdutosAgregadosListaCdDn: String! = ""
    
    var getListaDnGrupo: String! = ""
    
    
    func env(env : Environment) {
        
        //environment = env
        
        switch environment {
            
        case .development:
            keyCloakClientId = "commission-app"
            keyclokClientSecret = "vx6NXOpgsCYHdw819SpmM8fdsWKJZAzj"
            grantType = "password"
            keyclockUrl = "https://oauth2.uat.bancovw.com.br/realms/commission/protocol/openid-connect/token"
            baseUrl = "https://apic-gw-svc-uat.bancovw.com.br/volkswagen-financial-services/sandbox/api-cmm"
            getNews = "/api/v1/GetNoticias/"
            getPeriod = "/api/v1/GetPeriodoAvaliacao"
            clientId = "0cb8aa1eced9ce5ff53dc04f0e059436"
            clientSecret = "9a41da1b6c73f57d0df01f990b0d4012"
            imgBaseUrl = "https://cdn.uat.bancovw.com.br/CDN/cmm/"
            getDealers = "/api/v1/GetListaDealers"
            getGroups = "/api/v1/GetListaGrupos"
            getGroupProfile = "/api/v1/GetPerfilGrupo"
            getActualPeriod = "/api/v1/GetExercicioAtual"
            getDataCarga = "/api/v1/GetDataCarga"
            getIndiceVigenteVarejo = "/api/v1/IndiceVigente/Varejo/"
            getIndiceVigenteFrota = "/api/v1/IndiceVigente/Frota/"
            getSimulatorRealizado = "/api/v1/GetSimuladorRealizado/"
            getPeriodoVigenteVarejo = "/api/v1/PeriodoVigente/Varejo/"
            getPeriodoVigenteFrota = "/api/v1/PeriodoVigente/Frota/"
            getPerformedIndexVarejo = "/api/v1/IndicePerformadoGrupo/Varejo/"
            getPerformedIndexFrota = "/api/v1/IndicePerformadoGrupo/Frota/"
            getPerformedIndexAcelera = "/api/v1/IndicePerformadoGrupo/Acelera/"
            postSimuladorProjection = "/api/v1/SimuladorProjecao"
            getHistoryIndexVarejo = "/api/v1/PerformanceHistoricoVarejo/"
            getHistoryIndexFrota = "/api/v1/PerformanceHistoricoFrota/"
            getIndiceAceleraFrota = "/api/v1/GetHistoricoIndices/frota/"
            getIndiceAceleraVarejo = "/api/v1/GetHistoricoIndices/varejo/"
            getNotifications = "/api/v1/GetNotificacoes/"
            getVolumePenetrationVeiculosUsados = "/api/v1/GetFinanciamentoVeiculosUsadosGrupo/"
            getVolumePenetrationVeiculosNovos = "/api/v1/GetFinanciamentoVeiculosNovosGrupo/"
            getVolumePenetrationConsorcio = "/api/v1/GetConsorcioGrupo/"
            getVolumePenetration = "/api/v1/GetPenetrationGrupo/"
            getVolumePenetrationAak = "/api/v1/GetAakGrupo/"
            getPeriodosVolumePenetration = "/api/v1/PeriodosVolumePenetration"
            getVolumePenetrationIsrGrupo = "/api/v1/GetIsrGrupo/"
            getVolumeProdutosAgregados = "/api/v1/GetVolumeProdutosAgregados/"
            getListaDnGrupo = "/api/v1/GetListaDnGrupo"
            getVolumeProdutosAgregadosListaCdDn = "/api/v1/GetVolumeProdutosAgregadosListaCdDn/"
            
            print("It's for development")
            
        case .staging:
            keyCloakClientId = "commission-app"
            keyclokClientSecret = "vx6NXOpgsCYHdw819SpmM8fdsWKJZAzj"
            grantType = "password"
            keyclockUrl = "https://oauth2.uat.bancovw.com.br/realms/commission/protocol/openid-connect/token"
            baseUrl = "https://apic-gw-svc-uat.bancovw.com.br/volkswagen-financial-services/sandbox/api-cmm"
            getNews = "/api/v1/GetNoticias/"
            getPeriod = "/api/v1/GetPeriodoAvaliacao"
            clientId = "0cb8aa1eced9ce5ff53dc04f0e059436"
            clientSecret = "9a41da1b6c73f57d0df01f990b0d4012"
            imgBaseUrl = "https://cdn.uat.bancovw.com.br/CDN/cmm/"
            getDealers = "/api/v1/GetListaDealers"
            getGroups = "/api/v1/GetListaGrupos"
            getGroupProfile = "/api/v1/GetPerfilGrupo"
            getActualPeriod = "/api/v1/GetExercicioAtual"
            getDataCarga = "/api/v1/GetDataCarga"
            getSimulatorRealizado = "/api/v1/GetSimuladorRealizado/"
            postSimuladorProjection = "/api/v1/GetSimuladorRealizado/"
            getIndiceVigenteVarejo = "/api/v1/IndiceVigente/Varejo/"
            getIndiceVigenteFrota = "/api/v1/IndiceVigente/Frota/"
            getPeriodoVigenteVarejo = "/api/v1/PeriodoVigente/Varejo/"
            getPeriodoVigenteFrota = "/api/v1/PeriodoVigente/Frota/"
            getPerformedIndexVarejo = "/api/v1/IndicePerformadoGrupo/Varejo/"
            getPerformedIndexFrota = "/api/v1/IndicePerformadoGrupo/Frota/"
            getPerformedIndexAcelera = "/api/v1/IndicePerformadoGrupo/Acelera/"
            postSimuladorProjection = "/api/v1/SimuladorProjecao"
            getHistoryIndexVarejo = "/api/v1/PerformanceHistoricoVarejo/"
            getHistoryIndexFrota = "/api/v1/PerformanceHistoricoFrota/"
            getIndiceAceleraFrota = "/api/v1/GetHistoricoIndices/frota/"
            getIndiceAceleraVarejo = "/api/v1/GetHistoricoIndices/varejo/"
            getNotifications = "/api/v1/GetNotificacoes/"
            getVolumePenetrationVeiculosUsados = "/api/v1/GetFinanciamentoVeiculosUsadosGrupo/"
            getVolumePenetrationVeiculosNovos = "/api/v1/GetFinanciamentoVeiculosNovosGrupo/"
            getVolumePenetrationConsorcio = "/api/v1/GetConsorcioGrupo/"
            getVolumePenetration = "/api/v1/GetPenetrationGrupo/"
            getVolumePenetrationAak = "/api/v1/GetAakGrupo/"
            getPeriodosVolumePenetration = "/api/v1/PeriodosVolumePenetration"
            getVolumePenetrationIsrGrupo = "/api/v1/GetIsrGrupo/"
            getVolumeProdutosAgregados = "/api/v1/GetVolumeProdutosAgregados/"
            getListaDnGrupo = "/api/v1/GetListaDnGrupo"
            getVolumeProdutosAgregadosListaCdDn = "/api/v1/GetVolumeProdutosAgregadosListaCdDn/"
            
            print("It's for staging")
            
        case .production:
            keyCloakClientId = "commission-app"
            keyclokClientSecret = "7VrKxr2GR3YM52iE9Mo7042ZktT1J5H2"
            grantType = "password"
            //keyclockUrl = "https://oauth2.bancovw.com.br/"
            keyclockUrl = "https://oauth2.bancovw.com.br/realms/commission/protocol/openid-connect/token"
            baseUrl = "https://apic-gw-svc.bancovw.com.br/volkswagen-financial-services/sandbox/api-cmm"
            getNews = "/api/v1/GetNoticias/"
            getPeriod = "/api/v1/GetPeriodoAvaliacao"
            clientId = "beb41cb06474741dd6c3c198f975ec8b"
            clientSecret = "455d24b92855dde3cb24c3fd0f5433be"
            imgBaseUrl = "https://cdn.uat.bancovw.com.br/CDN/cmm/"
            getDealers = "/api/v1/GetListaDealers"
            getGroups = "/api/v1/GetListaGrupos"
            getGroupProfile = "/api/v1/GetPerfilGrupo"
            getActualPeriod = "/api/v1/GetExercicioAtual"
            getDataCarga = "/api/v1/GetDataCarga"
            getSimulatorRealizado = "/api/v1/GetSimuladorRealizado/"
            getIndiceVigenteVarejo = "/api/v1/IndiceVigente/Varejo/"
            getIndiceVigenteFrota = "/api/v1/IndiceVigente/Frota/"
            getPeriodoVigenteVarejo = "/api/v1/PeriodoVigente/Varejo/"
            getPeriodoVigenteFrota = "/api/v1/PeriodoVigente/Frota/"
            getPerformedIndexVarejo = "/api/v1/IndicePerformadoGrupo/Varejo/"
            getPerformedIndexFrota = "/api/v1/IndicePerformadoGrupo/Frota/"
            getPerformedIndexAcelera = "/api/v1/IndicePerformadoGrupo/Acelera/"
            postSimuladorProjection = "/api/v1/SimuladorProjecao"
            getHistoryIndexVarejo = "/api/v1/PerformanceHistoricoVarejo/"
            getHistoryIndexFrota = "/api/v1/PerformanceHistoricoFrota/"
            getIndiceAceleraFrota = "/api/v1/GetHistoricoIndices/frota/"
            getIndiceAceleraVarejo = "/api/v1/GetHistoricoIndices/varejo/"
            getNotifications = "/api/v1/GetNotificacoes/"
            getVolumePenetrationVeiculosUsados = "/api/v1/GetFinanciamentoVeiculosUsadosGrupo/"
            getVolumePenetrationVeiculosNovos = "/api/v1/GetFinanciamentoVeiculosNovosGrupo/"
            getVolumePenetrationConsorcio = "/api/v1/GetConsorcioGrupo/"
            getVolumePenetration = "/api/v1/GetPenetrationGrupo/"
            getVolumePenetrationAak = "/api/v1/GetAakGrupo/"
            getPeriodosVolumePenetration = "/api/v1/PeriodosVolumePenetration"
            getVolumePenetrationIsrGrupo = "/api/v1/GetIsrGrupo/"
            getVolumeProdutosAgregados = "/api/v1/GetVolumeProdutosAgregados/"
            getListaDnGrupo = "/api/v1/GetListaDnGrupo"
            getVolumeProdutosAgregadosListaCdDn = "/api/v1/GetVolumeProdutosAgregadosListaCdDn/"

            print("It's for production")
        }
    }
}
