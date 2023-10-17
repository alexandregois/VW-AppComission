//
//  Array.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 06/07/23.
//

import Foundation
import UIKit
import PDFKit

extension Array where Element: UIImage {
    
      func makePDF()-> PDFDocument? {
        let pdfDocument = PDFDocument()
        for (index,image) in self.enumerated() {
            let pdfPage = PDFPage(image: image)
            pdfDocument.insert(pdfPage!, at: index)
        }
        return pdfDocument
    }
}

