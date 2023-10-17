//
//  HistoryViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 13/07/23.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var indiceAceleraCard: UIView!
    @IBOutlet weak var setaImg: UIImageView!
    
    public init() {
        super.init(nibName: "HistoryViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Histórico"
        createSecondNavBar()
        indiceAceleraCard.cornerRadius(radius: 15)
        indiceAceleraCard.dropShadow()
        setaImg.tintColor = UIColor(named: "vwBlue")
        indiceAceleraCard.isUserInteractionEnabled = true
        indiceAceleraCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goToIndiceAcelera)))
    }
    
    @objc func goToIndiceAcelera() {
        let currentVC = IndiceAceleraViewController()
        self.navigationController?.pushViewController(currentVC, animated: true)
    }
}
