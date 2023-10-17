import SwiftUI


class LogoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        let logoView = LogoView()

        // Converte a LogoView (SwiftUI) em uma UIView (UIKit)
        let hostView = UIHostingController(rootView: logoView).view!
        hostView.backgroundColor = .white
        hostView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(hostView)

        // Garante que a LogoView preencha a tela inteira
        NSLayoutConstraint.activate([
            hostView.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            hostView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
