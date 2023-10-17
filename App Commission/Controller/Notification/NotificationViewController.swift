//
//  NotificationViewController.swift
//  App Commission
//
//  Created by Alexandre Gois on 24/07/23.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var genericErrorMsg: UILabel!
    
    @IBOutlet weak var notificationsTableView: UITableView!
    private var selectedNew: Notificacao?
    var notifications:[Notificacao] = []
    private var pullControl = UIRefreshControl()
    
    public init() {
        super.init(nibName: "NotificationViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        
        self.genericErrorMsg.isHidden = true
        self.notificationsTableView.delegate = self
        self.notificationsTableView.dataSource = self
        self.notificationsTableView.layer.cornerRadius = 15
        self.notificationsTableView.backgroundColor = .clear
        
        self.notificationsTableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        super.viewDidLoad()
        title = "Notificações"
        
        self.createSecondNavBar()
        self.createSpinnerView()
        self.pullControl.tintColor = UIColor.white
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        pullControl.attributedTitle = NSAttributedString(string: "Puxe para atualizar", attributes: attributes)
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            notificationsTableView.refreshControl = pullControl
        } else {
            notificationsTableView.addSubview(pullControl)
        }
        
        getNotifications()
    }
    
    @objc private func refreshListData(_ sender: Any) {
        getNotifications()
    }
    
    private func getNotifications() {
        
        NotificationService.shared.getNotifications { notifications, error in
            self.removeSpinnerView()
            self.pullControl.endRefreshing()
            if notifications != nil && !notifications!.isEmpty {
                
                let notificationsAtivas = notifications!.filter { $0.ST_ATIVO_COMUNICADO == "A" }
                
                self.genericErrorMsg.isHidden = true
                self.notifications = notificationsAtivas
                self.notificationsTableView.reloadData()
                
                
            } else {
                self.genericErrorMsg.isHidden = false
            }
        }
        
    }
    
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        
        //        if indexPath.section == 0 {
        //            cellHeight = 320
        //        }
        //        else  {
        cellHeight = 120
        //}
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedNew = notifications[indexPath.section]        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notification = notifications[indexPath.section]
        
        // Verificar se o ID_IMG_COMUNICADO é maior que 0
        if let idImgComunicado = notification.ID_IMG_COMUNICADO, idImgComunicado > 0 {
            // Usar a célula específica para notificações com imagem (NotificationImageCell)
            let cell = notificationsTableView.dequeueReusableCell(withIdentifier: "NotificationImageCell", for: indexPath) as! NotificationImageCell
            
            // Configurar a célula para notificações com imagem
            cell.layer.cornerRadius = 15
            cell.notificationView.layer.cornerRadius = 15
            cell.notificationTitle.text = notification.NM_COMUNICADO
            cell.notificationTexto.text = notification.DS_COMUNICADO
            
            print("\(Urls.shared.imgBaseUrl)\(String(describing: notification.ID_IMG_COMUNICADO!)).jpg")
            cell.notificationImg.loadFrom(URLAddress: "\(Urls.shared.imgBaseUrl)\(String(describing: notification.ID_IMG_COMUNICADO!)).jpg")
            
            if let dtComunicado = notification.DT_COMUNICADO?.components(separatedBy: "T")[0] {
                cell.notificationDate.text = Utils.formatStringDate(dtComunicado)
            } else {
                cell.notificationDate.text = ""
            }
            
            return cell
            
        } else {
            
            // Usar a célula padrão para notificações sem imagem (NotificationCell)
            let cell = notificationsTableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
            
            // Configurar a célula para notificações sem imagem
            cell.layer.cornerRadius = 15
            cell.notificationView.layer.cornerRadius = 15
            cell.notificationTitle.text = notification.NM_COMUNICADO
            cell.notificationTexto.text = notification.DS_COMUNICADO
            
            if let dtComunicado = notification.DT_COMUNICADO?.components(separatedBy: "T")[0] {
                cell.notificationDate.text = Utils.formatStringDate(dtComunicado)
            } else {
                cell.notificationDate.text = ""
            }
            
            return cell
        }
        
    }
    
    
}


