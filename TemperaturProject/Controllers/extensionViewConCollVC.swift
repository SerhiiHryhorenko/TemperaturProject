//
//  extensionViewConCollVC.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 17.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

    //MARK: - create CollectionViewCell
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTimeCV.count
    }
    
    func collectionView(
      _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCVTemp", for: indexPath) as! CellCollView
        collectionViewCell.hourCVLabel.text = "\(String(describing: arrayTimeCV[indexPath.row].first))"
        collectionViewCell.tempCVLabel.text = "\(arrayTemperCV[indexPath.row])"
        //collectionViewCell.backgroundColor = .clear
      return collectionViewCell
    }
    
}
