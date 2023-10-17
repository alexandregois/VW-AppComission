//
//  UIViewController.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 16/06/23.
//

import Foundation
import UIKit


extension UIViewController {
    
    func handleNetworkError(_ error: Error) {
        let alert = UIAlertController(title: "Falha de Comunicação", message: "Ocorreu um erro de comunicação com o servidor. Por favor, tente mais tarde.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func createNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let menuIcon = UIImage(named: "icon_menu")
        let notificationIcon = UIImage(named: "icon_notification")
        
        let leftBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(openMenu))
        leftBarButton.image = menuIcon
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(openNotification))
        rightBarButton.image = notificationIcon
        navigationItem.rightBarButtonItem = rightBarButton
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "logo_vw_financial")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
    
    func createSecondNavBar(_ showShareOption: Bool? = false) {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let backIcon = UIImage(named: "icon_back")
        let shareIcon = UIImage(systemName: "square.and.arrow.up")
        
        
        let leftBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(goBack))
        leftBarButton.image = backIcon
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        if showShareOption ?? false {
            let rightBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(shareScreen))
            rightBarButton.image = shareIcon
            navigationItem.rightBarButtonItem = rightBarButton
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "logo_vw_financial")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
    
    @objc func openMenu() {
        
        let viewController = MenuLateralViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    @objc func openNotification() {
        let pageP = NotificationViewController()
        self.navigationController?.pushViewController(pageP, animated: true)
    }
    
    @objc func shareScreen() {
        let image = view.takeScreenshot()
        UIGraphicsEndImageContext()
        
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func goBack() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController.spinner
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeSpinnerView() {
        let child = SpinnerViewController.spinner
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
