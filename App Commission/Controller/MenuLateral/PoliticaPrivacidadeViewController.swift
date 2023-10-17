import UIKit
import WebKit

class PoliticaPrivacidadeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        
        view.backgroundColor = .white
        
        let topView = UIView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 65))
        topView.backgroundColor = .white
        topView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped)))
        view.addSubview(topView)
        
        let closeButton = UIButton(frame: CGRect(x: view.frame.width - 45, y: 30, width: 45, height: 65))
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        topView.addSubview(closeButton)
        
        let textTittle = UILabel(frame: CGRect(x: 29, y: 30, width: view.frame.width, height: 65))
        textTittle.numberOfLines = 2
        textTittle.text = "Políticas de Privacidade"
        textTittle.font = UIFont.boldSystemFont(ofSize: 17) // Definindo a fonte em negrito
        textTittle.isUserInteractionEnabled = true
        textTittle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeButtonTapped)))
        topView.addSubview(textTittle)
        topView.addSubview(textTittle)
        
        // WebView
                let webView = WKWebView(frame: CGRect(x: 0, y: topView.frame.height + 50, width: view.frame.width, height: view.frame.height - topView.frame.height))
                if let url = URL(string: "https://www.vwfs.com.br/politica-de-privacidade.html") {
                    let request = URLRequest(url: url)
                    webView.load(request)
                }
                view.addSubview(webView)
        
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
