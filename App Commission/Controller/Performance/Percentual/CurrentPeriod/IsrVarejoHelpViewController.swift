//
//  IsrVarejoHelpViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 10/07/23.
//

import Foundation
import UIKit

class IsrVarejoHelpViewController: UIViewController {
    
    var tituloLabel: String = ""
    var descLabel: String = ""
    var subDescLabel: String = ""
    var superiorFormulaLabel: String = ""
    var inferiorFormulaLabel: String = ""
    
    @IBOutlet weak var closeBtn: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var superiorFormula: UILabel!
    @IBOutlet weak var inferiorFormula: UILabel!
    @IBOutlet weak var subDescricao: UILabel!
    
    public init() {
        super.init(nibName: "IsrVarejoHelpViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeBtn.isUserInteractionEnabled = true
        closeBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped)))
        
        titulo.text = self.tituloLabel
        descricao.text = self.descLabel
        subDescricao.text = self.subDescLabel
        superiorFormula.text = self.superiorFormulaLabel
        inferiorFormula.text = self.inferiorFormulaLabel
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
