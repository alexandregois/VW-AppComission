//
//  IncrementDecrementViewController.swift
//  App Commission
//
//  Created by Alexandre Gois on 10/07/23.
//

import Foundation
import UIKit

class IncrementDecrementViewController: UIViewController {
    
    var slideValue: String?
    var slideLabelValue: String?
    var initialSlideValue: Float?
    
    weak var delegate: IncrementDecrementViewControllerDelegate?
    
    var slideLabel2: UITextField?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupKeyboardHiding()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white.withAlphaComponent(0.5)
        
        let margin: CGFloat = 10.0
        
        let contentView = UIView()
        let contentViewHeight = view.frame.height / 3
        contentView.frame = CGRect(x: 0, y: view.frame.height - contentViewHeight, width: view.frame.width, height: contentViewHeight)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize.zero
        contentView.layer.shadowRadius = 10
        view.addSubview(contentView)
        
        let slideLabel = UILabel(frame: CGRect(x: margin, y: 15, width: contentView.frame.width - 2*margin, height: 50))
        slideLabel.text = slideLabelValue
        slideLabel.font = UIFont.boldSystemFont(ofSize: 24)
        slideLabel.textAlignment = .center
        contentView.addSubview(slideLabel)
        
        slideLabel2 = UITextField(frame: CGRect(x: (contentView.frame.width - 75) / 2.3, y: 75, width: 105, height: 50))
        slideLabel2?.delegate = self
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        if let floatValue = initialSlideValue {
            var formattedValue = numberFormatter.string(from: NSNumber(value: floatValue/100)) ?? ""
            formattedValue = formattedValue.replacingOccurrences(of: "%", with: "")
            slideLabel2?.text = formattedValue
        } else {
            slideLabel2?.text = "00,00"
        }
        
        slideLabel2?.placeholder = "00,00"
        
        slideLabel2?.textAlignment = .center
        slideLabel2?.keyboardType = .decimalPad // Teclado numérico com decimal
        slideLabel2?.returnKeyType = .done // Botão 'Done' no teclado
        slideLabel2?.addTarget(self, action: #selector(slideValueFieldChanged), for: .editingChanged) // Adiciona um alvo para o evento de mudança de edição
        
        if let slideLabel2 = slideLabel2 {
            contentView.addSubview(slideLabel2)
        }
        
        if let slideLabel2 = slideLabel2 {
            let percentLabel = UILabel(frame: CGRect(x: slideLabel2.frame.maxX + 1, y: 75, width: 20, height: 50))
            percentLabel.text = "%"
            percentLabel.textAlignment = .left
            contentView.addSubview(percentLabel)
        }
        
        let okButton = UIButton(type: .custom)
        okButton.frame = CGRect(x: 9, y: 165, width: contentView.frame.width - 18, height: 50)
        okButton.setTitle("Submeter", for: .normal)
        okButton.backgroundColor = UIColor(hex: 0x00B9F5)
        okButton.setTitleColor(UIColor.white, for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        okButton.layer.cornerRadius = 15  
        contentView.addSubview(okButton)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.frame = CGRect(x: contentView.frame.width / 2 - (contentView.frame.width/2 - 1.5*margin) / 2, y: 225, width: contentView.frame.width/2 - 1.5*margin, height: 50)
        cancelButton.setTitle("Cancelar", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        let incrementButton = UIButton(type: .custom)
        //incrementButton.frame = CGRect(x: contentView.frame.width/2 + 75, y: 75, width: 50, height: 50)
        incrementButton.frame = CGRect(x: contentView.frame.width - 50 - 15, y: 75, width: 50, height: 50)
        incrementButton.setTitle("+", for: .normal)
        incrementButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        incrementButton.backgroundColor = UIColor.white
        incrementButton.setTitleColor(UIColor(hex: 0x00B9F5), for: .normal)
        incrementButton.layer.cornerRadius = 25 // Adicionado para criar bordas arredondadas.
        incrementButton.layer.shadowColor = UIColor.gray.cgColor
        incrementButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        incrementButton.layer.shadowOpacity = 1
        incrementButton.layer.shadowRadius = 2.0
        incrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)
        contentView.addSubview(incrementButton)
        
        let decrementButton = UIButton(type: .custom)
        decrementButton.frame = CGRect(x: 15, y: 75, width: 50, height: 50)
        decrementButton.setTitle("-", for: .normal)
        decrementButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        decrementButton.backgroundColor = UIColor.white
        decrementButton.setTitleColor(UIColor(hex: 0x00B9F5), for: .normal)
        decrementButton.layer.cornerRadius = 25 // Adicionado para criar bordas arredondadas.
        decrementButton.layer.shadowColor = UIColor.gray.cgColor
        decrementButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        decrementButton.layer.shadowOpacity = 1
        decrementButton.layer.shadowRadius = 2.0
        decrementButton.addTarget(self, action: #selector(decrementButtonTapped), for: .touchUpInside)
        contentView.addSubview(decrementButton)
    }
    
    private func formatToTwoDecimalPlaces(text: String) -> String {
        let value = text.replacingOccurrences(of: ",", with: ".")
        
        if let doubleValue = Double(value) {
            return String(format: "%.2f", doubleValue).replacingOccurrences(of: ".", with: ",")
        }
        
        return text
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func slideValueFieldChanged(textField: UITextField) {
        if let newValue = textField.text?.replacingOccurrences(of: ",", with: "."), let newFloatValue = Float(newValue.replacingOccurrences(of: "%", with: "")) {
            initialSlideValue = newFloatValue // 100.0
            slideValue = newValue
            slideLabel2?.text = newValue
        }
    }
    
    @objc func incrementButtonTapped() {
        
        if var floatValue = initialSlideValue {
            floatValue += 0.01
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .percent
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.multiplier = 1
            
            var formattedValue = numberFormatter.string(from: NSNumber(value: floatValue)) ?? ""
            formattedValue = formattedValue.replacingOccurrences(of: "%", with: "")
            slideLabel2?.text = formattedValue
            
            slideValue = formattedValue
            initialSlideValue = floatValue
        }
    }
    
    @objc func decrementButtonTapped() {
        if var floatValue = initialSlideValue {
            floatValue -= 0.01
            if floatValue >= 0 {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .percent
                numberFormatter.minimumFractionDigits = 2
                numberFormatter.maximumFractionDigits = 2
                numberFormatter.multiplier = 1
                
                var formattedValue = numberFormatter.string(from: NSNumber(value: floatValue)) ?? ""
                formattedValue = formattedValue.replacingOccurrences(of: "%", with: "")
                slideLabel2?.text = formattedValue
                
                slideValue = formattedValue
                initialSlideValue = floatValue
            }
        }
    }
    
    @objc func endEdit() {
        view.endEditing(true)
    }
    
    @objc func okButtonTapped() {
        
        if slideValue == nil
        {
            slideValue = slideLabel2?.text
        }
        
        delegate?.didSelectSlideValue(slideValue ?? "0", withParameter: slideLabelValue)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

protocol IncrementDecrementViewControllerDelegate: AnyObject {
    func didSelectSlideValue(_ value: String, withParameter parameter: Any?)
}

extension IncrementDecrementViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let caracteresPermitidos = CharacterSet(charactersIn: "0123456789")
        let conjuntoDeCaracteres = CharacterSet(charactersIn: string)
        
        if !caracteresPermitidos.isSuperset(of: conjuntoDeCaracteres) {
            return false
        }
        
        let textoAtual = textField.text ?? ""
        let novoTexto = (textoAtual as NSString).replacingCharacters(in: range, with: string).replacingOccurrences(of: ",", with: "")
        
        if let valorInt = Int(novoTexto) {
            textField.text = formatarParaMoeda(valorInt: valorInt)
            return false
        } else if novoTexto.isEmpty {
            textField.text = ""
            return false
        }

        return true
    }
    
    private func formatarParaMoeda(valorInt: Int) -> String {
        return String(format: "%02d,%02d", valorInt / 100, valorInt % 100)
    }
}

extension IncrementDecrementViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        view.frame.origin.y = view.frame.origin.y - 250
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}


