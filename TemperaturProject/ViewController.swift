//
//  ViewController.swift
//  TemperaturProject
//
//  Created by Serhii Hryhorenko on 05.11.2019.
//  Copyright © 2019 Serhii Hryhorenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var arrayDay = ["Sunday", "Monday", "Tuesday", "Wensday", "Thursday", "Friday", "Saturday"]
    var arrayData = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    
    @IBOutlet weak var TableViewDay: UITableView!
    @IBOutlet weak var CollectionViewData: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdintifier: reuseIdintifier)
        // Do any additional setup after loading the view.
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Create sections
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           switch section {
           case 0:
               return 7
           case 1:
               return 1
           default:
               break
           }
           return arrayDay.count  // 0
       }
    
    //MARK: - create TableViewCell
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDayTemper", for: indexPath)
        
        let numberDay = arrayDay[indexPath.row]
        cell.textLabel?.text = numberDay
        return cell
    }
}

    //MARK: - create CollectionViewCell
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(
      _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "cellCVTemp", for: indexPath)
      cell.backgroundColor = .black
      return cell
    }
    
//    let collectionViewLayout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
////    collectionViewLayout.itemSize = UICollectionViewFlowLayout.automaticSize
////    collectionViewLayout.estimatedItemSize = CGSize(wi)
//
//    func preferredLayoutAttributesFitting(_layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        //setNeedsLayout()
//        layoutIfNeeded()
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var
//
//
//        return lauoutAttributes
//    }
    
    
}
