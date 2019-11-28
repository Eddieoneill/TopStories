//
//  HeadlineCell.swift
//  TopStories
//
//  Created by Edward O'Neill on 11/26/19.
//  Copyright © 2019 Edward O'Neill. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    
    // add a corner radius on a view we need to access the layer.cornerRadius property
    // override the layoutSubviews() method
    // layoutSubviews() gets called when the constraints and the view is getting presents in its superview
    
    override func layoutSubviews() {
        super.layoutSubviews() // implements any parents setup code
        
        // change the cornerRadius of the imageView's layer
        headlineImageView.layer.cornerRadius = 4 // CGFloat
    }
    
    func configureCell(for headline: NewsHeadline) {
        headlineTitleLabel.text = headline.title
        bylineLabel.text = headline.byline
        for data in headline.multimedia where data.format == "thumbLarge" {
            headlineImageView.load(url: URL(string: data.url)!)
        }
    }
    
}
