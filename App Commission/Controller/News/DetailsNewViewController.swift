//
//  DetailsNewViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 21/06/23.
//

import Foundation
import UIKit

class DetailsNewViewController: UIViewController {
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subTitleTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UITextView!
    
    var detailsNew: DetailsNew?
    
    
    public init() {
        super.init(nibName: "DetailsNewViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        createSecondNavBar(true)
        populateDetailNew()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementerd")
    }
    
    private func populateDetailNew() {
        titleTxt.text = detailsNew?.title
        subTitleTxt.text = detailsNew?.subTitle
        if let id = detailsNew?.idImg {
            print("\(Urls.shared.imgBaseUrl)\(id).jpg")
            img.loadFrom(URLAddress: "\(Urls.shared.imgBaseUrl)\(id).jpg")
        }
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 15
        descriptionTxt.text = detailsNew?.description
        descriptionTxt.isEditable = false
    }
    
    override func shareScreen() {
        let image = view.snapshot(scrollView: scrollView)
        UIGraphicsEndImageContext()
        
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}
