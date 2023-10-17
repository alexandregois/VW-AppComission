//
//  NewsViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 06/06/23.
//

import Foundation
import UIKit
import PDFKit

class NewsViewController: UIViewController {
    @IBOutlet weak var genericErrorMsg: UILabel!
    
    @IBOutlet weak var newsTableView: UITableView!
    private var selectedNew: New?
    var news:[New] = []
    private var pullControl = UIRefreshControl()
    
    
    public init() {
        super.init(nibName: "NewsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    override func viewDidLoad() {
        self.genericErrorMsg.isHidden = true
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.newsTableView.layer.cornerRadius = 15
        self.newsTableView.backgroundColor = .clear
        
        self.newsTableView.register(UINib(nibName: "PrincipalNewCell", bundle: nil), forCellReuseIdentifier: "PrincipalNewCell")
        self.newsTableView.register(UINib(nibName: "NewCell", bundle: nil), forCellReuseIdentifier: "NewCell")
        super.viewDidLoad()
        title = "Notícias"
        
        self.createNavBar()
        self.createSpinnerView()
        self.pullControl.tintColor = UIColor.white

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        
        pullControl.attributedTitle = NSAttributedString(string: "Puxe para atualizar", attributes: attributes)
                pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
                if #available(iOS 10.0, *) {
                    newsTableView.refreshControl = pullControl
                } else {
                    newsTableView.addSubview(pullControl)
                }
        
        getNew()
    }
    
    @objc private func refreshListData(_ sender: Any) {
            getNew()
        }
    
    private func getNew() {
        NewsService.shared.getNews { news, error in
            self.removeSpinnerView()
            self.pullControl.endRefreshing()
            if news != nil && !news!.isEmpty {
                self.genericErrorMsg.isHidden = true
                self.news = news!
                self.newsTableView.reloadData()
            } else {
                self.genericErrorMsg.isHidden = false
            }
        }
        
    }
    
    func goToDetails() {
        let detailsNewVC = DetailsNewViewController()
        detailsNewVC.detailsNew = createDetailsNew()
        self.navigationController?.pushViewController(detailsNewVC, animated: true)
    }
    
    private func createDetailsNew() -> DetailsNew {
        var subtitle = ""
        
        if let dtComunicado = selectedNew?.DT_COMUNICADO?.components(separatedBy: "T")[0] {
            subtitle = Utils.formatStringDate(dtComunicado)
        }
        
        let detail = DetailsNew(title: selectedNew!.NM_COMUNICADO!, subTitle: subtitle, idImg: selectedNew!.ID_IMG_COMUNICADO!, description: selectedNew!.DS_COMUNICADO!)
        
        return detail
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        newsTableView.reloadData()
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return news.count
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let new = news[indexPath.section]
        
        if indexPath.section == 0 {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "PrincipalNewCell", for: indexPath) as! PrincipalNewCell
            cell.layer.cornerRadius = 15
            cell.principalView.layer.cornerRadius = 15
            cell.principalImg.layer.cornerRadius = 15
            print("\(Urls.shared.imgBaseUrl)\(String(describing: new.ID_IMG_COMUNICADO!)).jpg")
            cell.principalImg.loadFrom(URLAddress: "\(Urls.shared.imgBaseUrl)\(String(describing: new.ID_IMG_COMUNICADO!)).jpg")
            cell.principalTitle.text = new.NM_COMUNICADO
            
            let attributedString = NSMutableAttributedString.init(string: "Leia Mais")
            
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                            NSRange.init(location: 0, length: attributedString.length));
            cell.leiaMais.attributedText = attributedString
            
            if let dtComunicado = new.DT_COMUNICADO?.components(separatedBy: "T")[0] {
                cell.principalDate.text = Utils.formatStringDate(dtComunicado)
            } else {
                cell.principalDate.text = ""
            }
            
            return cell
            
        } else {
            let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as! NewCell
            cell.layer.cornerRadius = 15
            cell.newView.layer.cornerRadius = 15
            cell.newImg.layer.cornerRadius = 15
            print("\(Urls.shared.imgBaseUrl)\(String(describing: new.ID_IMG_COMUNICADO!)).jpg")
            cell.newImg.loadFrom(URLAddress: "\(Urls.shared.imgBaseUrl)\(String(describing: new.ID_IMG_COMUNICADO!)).jpg")
            cell.newTitle.text = new.NM_COMUNICADO
            let attributedString = NSMutableAttributedString.init(string: "Leia Mais")
            
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                                            NSRange.init(location: 0, length: attributedString.length));
            cell.leiaMais.attributedText = attributedString
            
            if let dtComunicado = new.DT_COMUNICADO?.components(separatedBy: "T")[0] {
                cell.newDate.text = Utils.formatStringDate(dtComunicado)
            } else {
                cell.newDate.text = ""
            }
            
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        
        if indexPath.section == 0 {
            cellHeight = 320
        }
        else  {
            cellHeight = 120
        }
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedNew = news[indexPath.section]
        goToDetails()
        
    }

}
