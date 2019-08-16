//
//  ImageFeedItemTableViewCell.swift
//  PhotoFeed_NSUserDefaults
//
//  Created by nhp on 8/14/19.
//  Copyright © 2019 nhp. All rights reserved.
//

import UIKit

class ImageFeedItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemTitle: UILabel!
    
    weak var dataTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
