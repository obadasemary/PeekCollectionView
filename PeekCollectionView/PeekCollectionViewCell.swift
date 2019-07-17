//
//  CollectionViewCell.swift
//  PeekCollectionView
//
//  Created by Abdelrahman Mohamed on 17.07.2019.
//  Copyright © 2019 Abdelrahman Mohamed. All rights reserved.
//

import UIKit

class PeekCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
    }
}
