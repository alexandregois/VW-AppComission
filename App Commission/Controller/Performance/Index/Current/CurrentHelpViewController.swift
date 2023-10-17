//
//  CurrentHelpViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 03/07/23.
//

import Foundation
import UIKit

protocol PerformancePercentualCurrentPeriodPresentation {
    func redirectToCurrentPeriod(isFrota: Bool)
}

class CurrentHelperViewController: UIViewController {
    
    @IBOutlet weak var descriptionView: UILabel!
    @IBOutlet weak var periodView: UILabel!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var closeBtn: UILabel!
    
    var delegate: PerformancePercentualCurrentPeriodPresentation?
    
    let defaults = UserDefaults.standard
    var type: HelpType?
    var isFrota: Bool = false
    
    public init() {
        super.init(nibName: "CurrentHelperViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        closeBtn.isUserInteractionEnabled = true
        closeBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped)))
        
        let attributedString = NSMutableAttributedString.init(string: "Visualizar Período")
        
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                        NSRange.init(location: 0, length: attributedString.length));
        periodView.attributedText = attributedString
        
        periodView.isUserInteractionEnabled = true
        periodView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToCurrent)))
        
        if type == .performado {
            descriptionView.text = "É o índice de comissionamento que está sendo projetado para os dois próximos meses, considerando a avaliação do período anterior."
            titleView.text = "Índice Performado"
        } else {
            descriptionView.text = "É o índice de comissionamento que está recebendo no mês atual, obtido após avaliação do período anterior."
            titleView.text = "Índice Vigente"
        }
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goToCurrent() {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.redirectToCurrentPeriod(isFrota: isFrota)
    }
    
}

enum HelpType {
    case vigente
    case performado
}


