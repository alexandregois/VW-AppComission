import UIKit

class MenuLateralViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user: User?
    
    override func viewWillAppear(_ animated: Bool) {
        user = User.getGlobal()
        setupUI()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        let uiViews = view.subviews
            .filter {$0 is UIView}
        
        for uiview in uiViews {
            uiview.removeFromSuperview()
        }
        
        // Topo da página
        let topView = UIView(frame: CGRect(x: 0, y: 41, width: view.frame.width, height: 70))
        topView.backgroundColor = .white
        view.addSubview(topView)
        
        let imageViewTopo = UIImageView(frame: CGRect(x: 29, y: 17, width: view.frame.width / 2, height: 37))
        imageViewTopo.image = UIImage(named: "logo_vw_financial")
        topView.addSubview(imageViewTopo)
        
        let closeButton = UIButton(frame: CGRect(x: view.frame.width - 45, y: 15, width: 40, height: 40))
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        topView.addSubview(closeButton)
        
        // Texto com botão
        let textButtonView = UIView(frame: CGRect(x: 29, y: topView.frame.maxY + 50, width: view.frame.width - 20, height: 50))
        view.addSubview(textButtonView)
        
        
        let labels = textButtonView.subviews
            .filter {$0 is UILabel}
        
        for label in labels {
            label.removeFromSuperview()
        }
        
        //Usuario
        let textUsuario = UILabel(frame: CGRect(x: 0, y: 0, width: textButtonView.frame.width - 60, height: 40))
        textUsuario.numberOfLines = 2
        textUsuario.tag = 1
        
        if let unwrappedUserName = user?.name {
            let attributedText = NSMutableAttributedString(string: unwrappedUserName.uppercased())
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]
            attributedText.addAttributes(attributes, range: NSRange(location: 0, length: attributedText.length))
            textUsuario.attributedText = attributedText
        }
        
        
        
        
        
        textButtonView.addSubview(textUsuario)
        
        let textGrupo = UILabel(frame: CGRect(x: 0, y: 25, width: textButtonView.frame.width - 60, height: 40))
        textGrupo.numberOfLines = 2
        textGrupo.tag = 2
        
        if textGrupo.isDescendant(of: view) {
            textGrupo.removeFromSuperview()
        }
        
        if let unwrappedNomeFilial = user?.nomeFilial, let unwrappedCodigoDealer = user?.codigoDealer {
            let textoCompleto = unwrappedNomeFilial + " | DN: " + unwrappedCodigoDealer + "   "
            let attributedString1 = NSMutableAttributedString.init(string: textoCompleto)
            //textGrupo.text = textoCompleto
            
            // Reduz o tamanho da fonte
            textGrupo.font = UIFont.systemFont(ofSize: 13)
            
            if(ProfileAccess.shared.profile == .rel) {
                let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSAttributedString.Key.underlineStyle,
                                                                  NSAttributedString.Key.foregroundColor: UIColor.link
                ]
                
                let attributedString = NSMutableAttributedString.init(string: "Trocar", attributes: attributes)
                attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                                NSRange.init(location: 0, length: attributedString.length));
                attributedString1.append(attributedString)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTrocarTapped))
                textButtonView.addGestureRecognizer(tapGesture)
                
            }
            
            textGrupo.attributedText = attributedString1
            
            textButtonView.addSubview(textGrupo)
            
        }
        
        // Lista de tópicos
        let tableView = UITableView(frame: CGRect(x: 10, y: textButtonView.frame.maxY + 50, width: view.frame.width - 20, height: view.frame.height - (textButtonView.frame.maxY + 50)))
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func buttonTrocarTapped() {
        let groupVC = GroupViewController()
        groupVC.modalPresentationStyle = .fullScreen
        self.present(groupVC, animated: true, completion: nil)
    }
    
    // Métodos UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        // Define imagens diferentes para cada célula baseado no indexPath.row
        switch indexPath.row {
        case 0:
            cell.imageView?.image = UIImage(named: "person")
            cell.textLabel?.text = "Políticas de Privacidade"
        case 1:
            cell.imageView?.image = UIImage(named: "doctext")
            cell.textLabel?.text = "Termos de Uso"
        case 2:
            cell.imageView?.image = UIImage(named: "exit")
            cell.textLabel?.text = "Sair"
        default:
            break
        }
        
        let disclosureImageView = UIImageView(frame: CGRect(x: cell.contentView.frame.width + 17, y: 21, width: 20, height: 20))
        disclosureImageView.image = UIImage(named: "setaright")
        cell.contentView.addSubview(disclosureImageView)
        
        return cell
    }
    
    // Método UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            // Ação para Políticas de Privacidade
            let pageP = PoliticaPrivacidadeViewController()
            pageP.modalPresentationStyle = .fullScreen
            self.present(pageP, animated: true, completion: nil)
            break
        case 1:
            // Ação para Termos de Uso
            let pageP = TermoUsoViewController()
            pageP.modalPresentationStyle = .fullScreen
            self.present(pageP, animated: true, completion: nil)
            break
        case 2:
            // Ação para Sair
            let alertController = UIAlertController(title: "Confirmação", message: "Deseja realmente sair?", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { (action) in
                self.logout()
            }
            alertController.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: SystemKeys.CURRENT_TOKEN)
        UserDefaults.standard.removeObject(forKey: SystemKeys.CURRENT_USER)
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let loginVc = story.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = loginVc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
