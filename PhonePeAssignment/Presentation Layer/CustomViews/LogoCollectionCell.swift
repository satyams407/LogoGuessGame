//
//  LogoCollectionCell.swift
//  PhonePeAssignment
//
//  Created by Satyam Sehgal on 06/07/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class LogoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
  
    func configureCell(from model: LogoModel) {
        self.logoImageView.downloadFromLink(link: model.imgURL, contentMode: .scaleAspectFill)
    }
    
}
