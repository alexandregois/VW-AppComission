//
//  SlideViewController.swift
//  App Commission
//
//  Created by Alexandre Gois on 07/07/23.
//

import Foundation
import UIKit

class SlideViewController: UIViewController, UITextFieldDelegate {
    
    var slideValue: String?
    var slideLabelValue: String?
    var initialSlideValue: Float?
    
    weak var delegate: SlideViewControllerDelegate?
    
    var slideLabel2: UITextField?
    var slider: UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHiding()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .white.withAlphaComponent(0.5) // Isso fará com que a tela por trás seja um pouco visível.
        
        let margin: CGFloat = 10.0 // Definir a margem.
        
        // Crie uma nova subvisão para conter o conteúdo da tela.
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
        
        
        slider = UISlider(frame: CGRect(x: margin, y: 90, width: contentView.frame.width - 2*margin, height: 50))
        guard let slider = slider else { return }
        
        // Configure o slider.
        slider.minimumValue = 0
        slider.maximumValue = 5000
        slider.value = initialSlideValue ?? 0 // Use o valor inicial fornecido, ou 0 se nenhum valor inicial foi fornecido.
        slider.tintColor = UIColor(hex: 0x00B9F5) // Isso faz com que a linha e a bolinha de ajuste do slider sejam azuis.
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged) // Chame a função sliderValueChanged quando o valor do slider mudar.
        
        // Adicione o slider à visão.
        contentView.addSubview(slider)
        
        // Adicione labels para os valores mínimo e máximo do slider.
        let minValueLabel = UILabel(frame: CGRect(x: margin, y: 130, width: 50, height: 20))
        minValueLabel.text = "\(Int(slider.minimumValue))"
        contentView.addSubview(minValueLabel)
        
        let maxValueLabel = UILabel(frame: CGRect(x: contentView.frame.width - margin - 70, y: 130, width: 70, height: 20))
        maxValueLabel.text = "\(Int(slider.maximumValue))"
        maxValueLabel.textAlignment = .right
        contentView.addSubview(maxValueLabel)
        
        let slideLabel = UILabel(frame: CGRect(x: margin, y: 15, width: contentView.frame.width - 2*margin, height: 50))
        slideLabel.text = slideLabelValue
        slideLabel.font = UIFont.boldSystemFont(ofSize: 24)
        slideLabel.textAlignment = .center
        contentView.addSubview(slideLabel)
        
        slideLabel2 = UITextField(frame: CGRect(x: margin, y: 50, width: contentView.frame.width - 2*margin, height: 50))
        slideLabel2?.delegate = self
        slideLabel2?.text = String(format: "%.0f", initialSlideValue ?? 0) //Arredonda se for 2 casas decimais
        slideLabel2?.textAlignment = .center
        slideLabel2?.keyboardType = .decimalPad // Para permitir que apenas números sejam inseridos
        
        // Adicione um target para chamar uma função quando o valor do campo de texto mudar
        slideLabel2?.addTarget(self, action: #selector(slideValueFieldChanged), for: .editingChanged)
        
        if let slideLabel2 = slideLabel2 {
            contentView.addSubview(slideLabel2)
        }
        
        
        let okButton = UIButton(type: .custom)
        okButton.frame = CGRect(x: 9, y: 165, width: contentView.frame.width - 18, height: 50)
        okButton.setTitle("Submeter", for: .normal)
        okButton.backgroundColor = UIColor(hex: 0x00B9F5)
        okButton.setTitleColor(UIColor.white, for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        okButton.layer.cornerRadius = 15  // Adicionado para criar bordas arredondadas.
        contentView.addSubview(okButton)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.frame = CGRect(x: contentView.frame.width / 2 - (contentView.frame.width/2 - 1.5*margin) / 2, y: 225, width: contentView.frame.width/2 - 1.5*margin, height: 50)
        cancelButton.setTitle("Cancelar", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        contentView.addSubview(cancelButton)
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func sliderValueChanged(slider: UISlider) {
        // Atualize a propriedade slideValue e slideLabel2.text quando o valor do slider mudar.
        slideValue = String(format: "%.0f", slider.value)
        slideLabel2?.text = String(format: "%.0f", slider.value) //Arredonda se for 2 casas decimais
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet) && !(string.count > 0 && textField.text?.contains(",") == true && string.contains(","))
    }
    
    @objc func slideValueFieldChanged(textField: UITextField) {
        if let newValue = textField.text, let newFloatValue = Float(newValue) {
            // Atualize a propriedade slideValue e o valor do slider
            slideValue = newValue
            slider?.value = newFloatValue
        }
    }
    
    @objc func okButtonTapped() {
        
        if slideValue == nil
        {
            slideValue = slideLabel2?.text
        }
        
        delegate?.didSelectSlideValue(slideValue ?? "0", withParameter: slideLabelValue)
        dismiss(animated: true, completion: nil)
        // Ação do botão OK
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
        // Ação do botão Cancelar
    }
    
    @objc func endEdit() {
        view.endEditing(true)
    }
    
}

protocol SlideViewControllerDelegate: AnyObject {
    func didSelectSlideValue(_ value: String, withParameter parameter: Any?)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Valor inválido para vermelho")
        assert(green >= 0 && green <= 255, "Valor inválido para verde")
        assert(blue >= 0 && blue <= 255, "Valor inválido para azul")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}

extension SlideViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        view.frame.origin.y = view.frame.origin.y - 250
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
