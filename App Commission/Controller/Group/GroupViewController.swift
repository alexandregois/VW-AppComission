import UIKit
class GroupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var groupSelectField: UITextField!
    @IBOutlet weak var dnSelectField: UITextField!
    @IBOutlet weak var closeImg: UIImageView!
    var allGroups: [String] = []
    var groups: [String] = []
    var allDns: [String] = []
    var dns: [String] = []
    
    var groupPickerView = UIPickerView()
    var dnPickerView = UIPickerView()
    
    var groupSelected: String?
    var dnSelected: String?
    
    public init() {
        super.init(nibName: "GroupViewController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        groupSelectField.delegate = self
        
        closeImg.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(tap)
        
        closeImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped)))
        
        
        
        let customInputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240 + 40))
        groupPickerView.frame = CGRect(x: 0, y: 0, width: customInputView.frame.width, height: 240)
        customInputView.addSubview(groupPickerView)
        let confirmButton = UIButton(type: .system)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        confirmButton.setAttributedTitle(NSAttributedString(string: "Confirmar", attributes: attributes), for: .normal)

        confirmButton.setTitle("Confirmar", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        confirmButton.frame = CGRect(x: 0, y: groupPickerView.frame.maxY - 15, width: customInputView.frame.width, height: 40)
        customInputView.addSubview(confirmButton)
        groupSelectField.inputView = customInputView
        
                
        
        
        let customInputViewForDn = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240 + 40))
        dnPickerView.frame = CGRect(x: 0, y: 0, width: customInputViewForDn.frame.width, height: 240)
        customInputViewForDn.addSubview(dnPickerView)
        let confirmButtonForDn = UIButton(type: .system)
        let attributesForDn: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        confirmButtonForDn.setAttributedTitle(NSAttributedString(string: "Confirmar", attributes: attributesForDn), for: .normal)
        confirmButtonForDn.addTarget(self, action: #selector(confirmButtonTappedForDn), for: .touchUpInside)
        confirmButtonForDn.frame = CGRect(x: 0, y: dnPickerView.frame.maxY - 15, width: customInputViewForDn.frame.width, height: 40)
        customInputViewForDn.addSubview(confirmButtonForDn)
        dnSelectField.inputView = customInputViewForDn


        
        
        
        dnSelectField.isEnabled = false
        groupSelectField.placeholder = "Selecione"
        dnSelectField.placeholder = "Selecione"
        groupSelectField.textAlignment = .center
        dnSelectField.textAlignment = .center
        
        //groupSelectField.inputView = groupPickerView
        //dnSelectField.inputView = dnPickerView
        
        groupPickerView.delegate = self
        groupPickerView.dataSource = self
        
        dnPickerView.delegate = self
        dnPickerView.dataSource = self
        
        groupPickerView.tag = 1
        dnPickerView.tag = 2
        self.createSpinnerView()
        
        GroupService.shared.getGroups { groupList, error in
            
            self.removeSpinnerView()
            
            if let groupList = groupList {
                
                self.allGroups = groupList
                self.groups = groupList
                self.groupPickerView.reloadAllComponents()
                
            } else {
                
                let alertController = UIAlertController(title: "Ops..", message: "Estamos passando por algum problema.. :(", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
                    self.dismiss(animated: true, completion: nil)
                    
                }
                
                alertController.addAction(confirmAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                self.groupSelectField.isEnabled = false
            }
            
        }
        
    }
    
    @objc func confirmButtonTappedForDn() {
        let row = dnPickerView.selectedRow(inComponent: 0)
        let selectedDn = dns[row]

        dnSelected = selectedDn
        dnSelectField.text = dnSelected
        
        if dns[row] != " " {
            
            dnSelected = dns[row]
            dnSelectField.text = dnSelected
            dnSelectField.resignFirstResponder()
            self.updateUser()
            self.dismiss(animated: true, completion: nil)
            
        }
    }

    
    @objc func confirmButtonTapped() {
        let row = groupPickerView.selectedRow(inComponent: 0)
        let selectedGroup = groups[row]

        groupSelected = selectedGroup
        groupSelectField.text = groupSelected
        
        if groups[row] != " " {
            
            groupSelected = groups[row]
            groupSelectField.text = groupSelected
            dnSelectField.isEnabled = true
            self.createSpinnerView()
            
            GroupService.shared.getGroupProfile(groupName: groups[row]) { dnList, error in
                
                self.removeSpinnerView()
                
                if dnList != nil {
                    
                    self.dns = dnList!
                    self.allDns = dnList!
                    
                    self.dnPickerView.reloadAllComponents()
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Ops..", message: "Estamos passando por algum problema.. :(", preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "ok", style: .default) { (action) in
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    self.groupSelectField.isEnabled = false
                    
                }
            }
            groupSelectField.resignFirstResponder()
        }
    }
    
    @objc func endEdit() {
        view.endEditing(true)
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func groupTextFieldDidChange(_ textField: UITextField) {
        let searchText = textField.text ?? ""
        
        self.dnSelectField.text = ""
        self.dns = []
        self.dnPickerView.reloadAllComponents()
        
        if searchText.isEmpty {
            self.groups = self.allGroups
        } else {
            self.groups = self.allGroups.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        
        self.groupPickerView.reloadAllComponents()
        
        if let index = self.groups.firstIndex(where: { $0.lowercased() == searchText.lowercased() }) {
            self.groupPickerView.selectRow(index, inComponent: 0, animated: false)
            self.pickerView(self.groupPickerView, didSelectRow: index, inComponent: 0)
        }
        
    }
    
    @objc func dnTextFieldDidChange(_ textField: UITextField) {
        
        let searchText = textField.text ?? ""
        
        if searchText.isEmpty {
            self.dns = self.allDns
        } else {
            self.dns = self.allDns.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        
        self.dnPickerView.reloadAllComponents()
        
        // Encontre o índice do valor no picker que corresponde ao texto do textField.
        if let index = self.dns.firstIndex(where: { $0.lowercased() == searchText.lowercased() }) {
            // Se um valor correspondente for encontrado, selecione-o no picker.
            self.dnPickerView.selectRow(index, inComponent: 0, animated: false)
            // Chame manualmente o método de seleção do pickerView.
            self.pickerView(self.dnPickerView, didSelectRow: index, inComponent: 0)
        }
    }
}

extension GroupViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == groupSelectField {
            // Remover o botão
            if let button = view.viewWithTag(1001) as? UIButton {
                button.removeFromSuperview()
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
            
        case 1:
            return groups.count
            
        case 2:
            return dns.count
            
        default:
            return 1
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
            
        case 1:
            return groups[row]
            
        case 2:
            return dns[row]
            
        default:
            return "Data not found"
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // Verifica se é o groupPickerView e retorna, para evitar a seleção automática
//        if pickerView == groupPickerView {
//            return
//        }
        
        switch pickerView.tag {
            
        case 1:
            ""
        case 2:
            ""
            
        default:
            
            dnSelectField.text = "Selecione"
            groupSelectField.text = "Selecione"
            
        }
        
    }
    
    private func updateUser() {
        
        var user = User.getGlobal()
        user?.nomeFilial = groupSelected!
        user?.codigoDealer = dnSelected!
        user?.saveGlobal()
        
    }
    
}
