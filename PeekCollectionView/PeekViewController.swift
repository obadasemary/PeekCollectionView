//
//  ViewController.swift
//  PeekCollectionView
//
//  Created by Abdelrahman Mohamed on 16.07.2019.
//  Copyright © 2019 Abdelrahman Mohamed. All rights reserved.
//

import UIKit

private let peekCollectionViewCell = "PeekCollectionViewCell"

// side note: you don't need to conform to both (UICollectionViewDelegateFlowLayout, UICollectionViewDelegate) becuase UICollectionViewDelegateFlowLayout already inherits UICollectionViewDelegate
class PeekViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var imageArray: [String] = ["snow0", "snow1", "snow2", "snow3", "snow4", "snow5", "snow6", "snow7", "snow8", "snow9", "snow10", "snow11", "snow12"]

    enum Constants {

        static let cellSpacing: CGFloat = 20
        static let cellPeekWidth: CGFloat = 20
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    func configureViews() {

        // next line makes the snapping effect work exactly as we want, it controls the behavior of scrolling after the user lifts his finger so it looks native experience
        collectionView.decelerationRate = .fast
        
        // our new calculations use collection view left content inset instead of sections insets
        let sidePadding: CGFloat = Constants.cellSpacing + Constants.cellPeekWidth
        collectionView.contentInset = .init(top: 0, left: sidePadding, bottom: 0, right: sidePadding)
        
        collectionView.delegate = self
        collectionView.dataSource = self

        addNavBarImage()
    }

    func addNavBarImage() {
        let imageView = UIImageView(frame: (CGRect(x: 0, y: 0, width: 40, height: 40)))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage (named: "vngrs_red_logo")
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
}

extension PeekViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: peekCollectionViewCell, for: indexPath) as! PeekCollectionViewCell
        cell.imageView.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
}

extension PeekViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {

        let itemWidth = max(0, collectionView.frame.size.width - 2 * (Constants.cellSpacing + Constants.cellPeekWidth))
        return CGSize(width: itemWidth, height: collectionView.frame.size.height - 10.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return Constants.cellSpacing
    }
}
