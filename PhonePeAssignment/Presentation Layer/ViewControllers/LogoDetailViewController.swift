//
//  LogoDetailViewController.swift
//  PhonePeAssignment
//
//  Created by Satyam Sehgal on 06/07/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

protocol UpdateScoreDelegate: class {
    func updateScore(by value: Int)
}

// Forgive about the hard coding
class LogoDetailViewController: UIViewController, CharSelectedDelegate {
    
    @IBOutlet weak var logoDetailImageView: UIImageView!
    @IBOutlet weak var alphabetsCollectionView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var logoTextField: UITextField!
    
    var logoModel: LogoModel?
    var logoName = ""
    weak var updateScoreDelegate: UpdateScoreDelegate?
    
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetup()
        runTimer()
    }

    private func screenSetup() {
        if let model = logoModel {
             logoDetailImageView.downloadFromLink(link: model.imgURL, contentMode: .scaleAspectFill)
            logoName = model.name
        }
    }
    
    func charSelected(value: String) {
        logoTextField.text?.append(value)
        if compareWithLogoName(from: value) {
            // increase the score according to the level of game
            updateScoreDelegate?.updateScore(by: 1)
            navigationController?.popViewController(animated: true)
        }
    }

    private func compareWithLogoName(from text: String) -> Bool {
        return logoName.lowercased() == text
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text = "\(seconds)"
        
        if seconds == 0 {
            timer.invalidate()
            Utility.showAlert(title: "Oops!", message: "Try again", onController: self)
            // TODO - on tap of ok only start the timer again
            seconds = 60
            runTimer()
        }
    }
}

// MARK: Collection View datasource and delegate methods
extension LogoDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 26 // can get datasource by applying the logic to create jumbled character (but didnt the time sorry)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionCell", for: indexPath)
        if let cell = collectionCell as? CharacterCollectionViewCell {
            cell.configureCell()
            cell.charSelectedDelegate = self
        }
       return collectionCell
    }
}
