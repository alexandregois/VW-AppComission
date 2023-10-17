//
//  NewCell.swift
//  App Commission
//
//  Created by Camilo Oscar Girardelli Baptista on 29/06/23.
//

import Foundation
import UIKit

class NewCell: UITableViewCell {
    
    @IBOutlet weak var newImg: UIImageView!
    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var newDate: UILabel!
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var leiaMais: UILabel!
    
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
