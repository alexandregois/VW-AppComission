//
//  PeriodViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 06/06/23.
//

import Foundation
import UIKit

class PeriodViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var periodCollectionView: UICollectionView!
    @IBOutlet weak var principalCardView: UIView!
    
    var periods:[Period] = []
    
    
    public init() {
        super.init(nibName: "PeriodViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        principalCardView.dropShadow()
        principalCardView.cornerRadius(radius: 15)
        
        view.backgroundColor = .white
        title = "Período"
        createNavBar()
        
        periodCollectionView.dataSource = self
        periodCollectionView.delegate = self
        periodCollectionView.register(PeriodCell.self, forCellWithReuseIdentifier: "cell")
        
        self.createSpinnerView()
        
        ServicePeriod.shared.getPeriod { periodos, error in
            self.removeSpinnerView()
            
            if periodos != nil && !periodos!.isEmpty {
                
                print(periodos![0])
                self.periods = periodos!
                self.periodCollectionView.reloadData()
                
                
            } else {
                print(error as Any)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let x = (periodCollectionView.bounds.width / 8) - 3
        return CGSize(width: x, height: 39)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return periods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PeriodCell
        let periodo = periods[indexPath.row]
        
        if periodo.PAGAMENTO ?? false {
            cell.backView.backgroundColor = UIColor(named: "vwBlue")! // .darkGray //00B9F5
        }
        else
        {
            cell.backView.backgroundColor = UIColor(hex: 0x007AFF)
        }
            
        
        cell.periodLabel.text = periodo.MES
        cell.periodLabel.textColor = .white
        
        return cell
    }
    
}

class PeriodCell: UICollectionViewCell {
    
    let backView = UIView()
    let periodLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backView.backgroundColor = UIColor(named: "vwBlue")!
        periodLabel.text = "OUT"
        periodLabel.textColor = .white
        periodLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        
        addSubview(backView)
        backView.addSubview(periodLabel) // Adicione periodLabel à backView
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        periodLabel.translatesAutoresizingMaskIntoConstraints = false // Configurando restrições para periodLabel
        periodLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        periodLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
