//
//  ViewController.swift
//  PhonePeAssignment
//
//  Created by Satyam Sehgal on 06/07/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

// MARK: Used hard coding(becz of timeline) can do via making seperate constants file
class HomeViewController: UIViewController, UpdateScoreDelegate {
    @IBOutlet weak var logoCollectionView: UICollectionView!
    @IBOutlet weak var scoreValueLabel: UILabel!
    
    var logoDataSource = [LogoModel]()
    var guessedCorrectly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLogosLocally()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if guessedCorrectly {
            Utility.showAlert(title: "Won", message: "You have guessed the logo correclty", onController: self)
        }
    }
    
    private func registerCell() {
        let nib = UINib.init(nibName: "LogoCollectionCell", bundle: nil)
        logoCollectionView.register(nib, forCellWithReuseIdentifier: "LogoCollectionCell")
    }
    
    private func fetchLogosLocally() {
        if let jsonArray = Utility.readJSONFromFile(fileName: "Response") as? [[String: Any]] {
            for json in jsonArray {
                if let logoModel = LogoModel(with: json) {
                    logoDataSource.append(logoModel)
                }
            }
        }
    }
    
    func updateScore(by value: Int) {
        if let intValue = Int(scoreValueLabel.text ?? "") {
            guessedCorrectly = true
            scoreValueLabel.text =  "\(intValue + value)"
        }
    }
}

// MARK: Collection View datasource and delegate methods
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return logoDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogoCollectionCell", for: indexPath)
        if let cell = collectionCell as? LogoCollectionCell {
            cell.configureCell(from: logoDataSource[indexPath.row])
        }
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width - 40, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(withIdentifier: "LogoDetailViewController") as? LogoDetailViewController {
            detailVC.logoModel = self.logoDataSource[indexPath.row]
            detailVC.updateScoreDelegate = self
            guessedCorrectly = false
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

