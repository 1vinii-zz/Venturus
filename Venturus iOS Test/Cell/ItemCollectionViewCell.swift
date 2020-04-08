//
//  ItemCollectionViewCell.swift
//  Venturus iOS Test
//
//  Created by Vinícius Brito on 08/04/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(data: Image) {
        activityIndicator.startAnimating()
        imageView.kf.setImage(with: URL(string: data.link)) { result in
          switch result {
          case .success( _):
            self.imageView.contentMode = UIView.ContentMode.scaleAspectFill
            self.activityIndicator.stopAnimating()
          case .failure( _):
            self.activityIndicator.stopAnimating()
          }
        }
        
    }
    
}
