//
//  NotificationCell.swift
//  App Commission
//
//  Created by Alexandre Gois on 24/07/23.
//

import Foundation
import UIKit


class NotificationCell: UITableViewCell {

    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationTexto: UILabel!
    @IBOutlet weak var notificationDate: UILabel!
    @IBOutlet weak var notificationView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 5
            frame.size.width -= 2 * 5
            super.frame = frame
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

