//
//  MainTableViewCell.swift
//  session206
//
//  Created by Alex Telek on 07/12/2014.
//  Copyright (c) 2014 Alex Telek. All rights reserved.
//

import UIKit

@objc protocol MainTableCellDelegate {
    // call delegate when user clicked on image
    optional func didClickOnImage(image: UIImageView);
}

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var messageImage: UIImageView!
    
    var delegate: MainTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        messageImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didClickImage:")))
        
        cellSetup()
    }
    
    func cellSetup() {
        detailsView.layer.shadowOffset = CGSizeMake(-0.2, -0.2)
        detailsView.layer.shadowRadius = 2.0
        detailsView.layer.shadowOpacity = 0.3
        detailsView.layer.shadowColor = UIColor.blackColor().CGColor
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func didClickImage(gesture: UITapGestureRecognizer) {
        println("image clicked")
        delegate!.didClickOnImage!(messageImage)
    }
    
}
