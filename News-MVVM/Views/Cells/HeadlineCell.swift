//
//  HeadlineCell.swift
//  news
//
//  Created by mac2 on 9/6/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit
import Kingfisher

class HeadlineCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var headlineImage: UIImageView!
    @IBOutlet weak var headlineTitle: UILabel!
    @IBOutlet weak var headlineAuthor: UILabel!
    @IBOutlet weak var headlineDescription: UILabel!
        
    class func getCellIdentifier() -> String {
        return reuseIdentifier
    }

    func configure(data: Article) {
        if data.title != nil && data.descriptionValue != nil {
        self.headlineTitle.text = data.title
        self.headlineAuthor.text = data.author
        self.headlineDescription.text = data.descriptionValue
        self.setHeadlineImage(imageUrl: data.urlToImage)
        }
    }
    
    private func setHeadlineImage(imageUrl: String?) {
        
        if let photo = imageUrl{
            let url = URL(string: photo)
            headlineImage.kf.setImage(with: url)
        }
      
        
    }

}




