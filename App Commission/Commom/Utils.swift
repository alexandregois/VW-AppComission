//
//  Utils.swift
//  App Commission
//
//  Created by Alexandre Gois on 20/07/23.
//

import Foundation

class Utils {
    
    static func formatPercentual(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let valueAsPercent = value / 100.0
        let formattedString = formatter.string(from: NSNumber(value: valueAsPercent)) ?? ""
        
        // Verifica se a string formatada termina com ".0"
        if formattedString.hasSuffix(".0") {
            // Remove o ".0" no final da string
            let index = formattedString.index(formattedString.endIndex, offsetBy: -2)
            return String(formattedString[..<index])
        }
        
        return formattedString
    }
    
    static func formatCasaDecimal(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "pt_BR")  // Use as convenções brasileiras para separadores de milhares e decimais
        
        if floor(value) == value {
            // Se o valor é um número inteiro, defina maximumFractionDigits para 0
            formatter.maximumFractionDigits = 0
        } else {
            // Se o valor tem casas decimais não-zero, defina maximumFractionDigits para 2
            let decimalPart = value.truncatingRemainder(dividingBy: 1)
            if decimalPart > 0.00 {
                formatter.maximumFractionDigits = 2
            } else {
                formatter.maximumFractionDigits = 0
            }
        }
        
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    
    static func formatData(_ value: String) -> String {
        
        let inputDateString = value

        var outputDateString = ""
        
        // Cria um DateFormatter para analisar a string de entrada
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        // Usa o inputFormatter para converter a string de entrada em um Date
        if let date = inputFormatter.date(from: inputDateString) {
            // Cria um segundo DateFormatter para formatar o Date
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"

            // Usa o outputFormatter para formatar o Date como uma string sem a hora
            outputDateString = outputFormatter.string(from: date)

            print(outputDateString)
            
        } else {
            print("A string de data de entrada não pôde ser analisada.")
        }

        
        return outputDateString
        
    }
    
    static func formatDataHora(_ value: String) -> String {
        
        let inputDateString = value

        var outputDateString = ""
        
        // Cria um DateFormatter para analisar a string de entrada
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        // Usa o inputFormatter para converter a string de entrada em um Date
        if let date = inputFormatter.date(from: inputDateString) {
            // Cria um segundo DateFormatter para formatar o Date
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy HH:mm"

            // Usa o outputFormatter para formatar o Date como uma string sem a hora
            outputDateString = outputFormatter.string(from: date)

            print(outputDateString)
            
        } else {
            print("A string de data de entrada não pôde ser analisada.")
        }

        
        return outputDateString
        
    }
    
    static func removePontoDeString(input: String) -> String {
        let output = input.replacingOccurrences(of: ".", with: "")
        return output
    }
    
    static func formatStringDate( _ stringDate: String) -> String {
        let dates = stringDate.components(separatedBy: "-")
        
        if dates.count == 3 {
            return "\(dates[2])/\(dates[1])/\(dates[0])"
        } else {
            return stringDate
        }
    }
    
}
