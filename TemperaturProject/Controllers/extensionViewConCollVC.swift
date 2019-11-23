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
        return arrayTime.count / 2
    }
    
    func collectionView(
      _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let collectionViewCell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "cellCVTemp", for: indexPath)
      collectionViewCell.backgroundColor = .clear
      return collectionViewCell
    }
    
}
