//
//  InterestCollectionViewCell.swift
//  PsychoTestsAR
//
//  Created by Apple on 18/04/2019.
//  Copyright © 2019 PUMTeam. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    var interest: Interest? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI()
    {
        if let interest = interest {
            featuredImageView.image = interest.featuredImage
            interestTitleLabel.text = interest.title
            backgroundColorView.backgroundColor = interest.color
        } else {
            featuredImageView.image = nil
            interestTitleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
}








