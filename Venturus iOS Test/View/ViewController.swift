//
//  ViewController.swift
//  Venturus iOS Test
//
//  Created by Vinícius Brito on 08/04/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Item {
    var imageName: String
}

class ViewController: UIViewController {

    // MARK: - <Properties>
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "ItemCollectionViewCell"
    var collectionViewFlowLayout : UICollectionViewFlowLayout!
    var images = [Image]()
    var actualPage: Int = 0
    
    // MARK: - <Lifecycle>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataForCollectionView(searchText: "cats")
        setupCollectionView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }

    // MARK: - CollectionView Setup
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let numberOfItemPerRow: CGFloat = 3
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 5
            
            let width = (collectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    /*
    The function below calls the API, parse the response to Model then hold the data in a property to show it on CollectionView. The searchText value is hardcoded ("cats") as per requirement, but could be a text of a UISearchBar or a UITextField. It also checks for internet connection and shows an alert in case no connection.
     */
    
    func getDataForCollectionView(searchText: String) {
        Webservice.getData(searchText: searchText, page: actualPage) { (success, json) in

            guard let json = json, success == true else {
                return
            }

            let jsonList = DataModel.parse(json: json)
            self.images = jsonList.data
            self.collectionView.reloadData()
        }
        
    }
    
}

// MARK: - <UICollectionViewDelegate, UICollectionViewDataSource>

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        /* The cell configuration happens on cell itself */
        cell.setup(data: images[indexPath.item])
        return cell
    }
    
}
