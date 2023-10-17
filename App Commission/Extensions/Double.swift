//
//  Double.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 03/07/23.
//

import Foundation


extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
