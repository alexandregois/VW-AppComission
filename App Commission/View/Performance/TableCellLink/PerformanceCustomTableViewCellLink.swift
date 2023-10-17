//
//  PerformanceCustomTableViewCell.swift
//  App Commission
//
//  Created by Alexandre Gois on 07/08/23.
//

import Foundation
import UIKit

class PerformanceCustomTableViewCellLink: UITableViewCell {
    
    @IBOutlet weak var viewEsquerda: UIView!
    @IBOutlet weak var viewDireita: UIView!
    @IBOutlet weak var textoEsquerdo: UILabel!
    @IBOutlet weak var textoDireito: UILabel!
    @IBOutlet weak var textoLinkDetalhes: UILabel!
    
    
    var corViewDireita: UIColor?
    var corTextoDireito: UIColor?
    
    func configurarCores(viewDireitaColor: UIColor, textoDireitoColor: UIColor) {
        self.corViewDireita = viewDireitaColor
        self.corTextoDireito = textoDireitoColor
        self.viewDireita.backgroundColor = viewDireitaColor
        self.textoDireito.textColor = textoDireitoColor
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.7  // Define a largura da borda
        self.layer.borderColor = UIColor.white.cgColor  // Define a cor da borda para branco
        
//        textoLinkDetalhes.isUserInteractionEnabled = true
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
//        textoLinkDetalhes.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 5
            frame.size.width -= 2 * 5
            super.frame = frame
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
