//
//  CharacterCollectionViewCell.swift
//  PhonePeAssignment
//
//  Created by Satyam Sehgal on 06/07/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

protocol CharSelectedDelegate: class {
    func charSelected(value: String)
}

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterButton: UIButton!
    
    var jumbledCharArray = Array<String>()
    weak var charSelectedDelegate: CharSelectedDelegate?
    
    func configureCell() {
        let randomChar = randomString(length: 1)
        if !jumbledCharArray.contains(randomChar) {
            jumbledCharArray.append(randomChar)
            characterButton.setTitle(randomChar, for: .normal)
        } else {
           // apply logic for jumbled string and also that contain in logoname
            // restrict the data source count as only need to show relevant characters
        }
    }
    
    @IBAction func didTapOnCharacterButton(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            charSelectedDelegate?.charSelected(value: title)
        }
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
