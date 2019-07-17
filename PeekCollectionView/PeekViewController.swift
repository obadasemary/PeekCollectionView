//
//  ViewController.swift
//  PeekCollectionView
//
//  Created by Abdelrahman Mohamed on 16.07.2019.
//  Copyright © 2019 Abdelrahman Mohamed. All rights reserved.
//

import UIKit

private let peekCollectionViewCell = "PeekCollectionViewCell"

class PeekViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    var imageArray: [String] = ["snow0", "snow1", "snow2", "snow3", "snow4", "snow5"]

    enum Constants {

        static let cellSpacing: CGFloat = 20
        static let cellPeekWidth: CGFloat = 20
        static let scrollThreshold: CGFloat = 50
    }

    var itemWidth: CGFloat = 0
    fileprivate var currentScrollOffset: CGPoint = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    }

    func configureViews() {

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - UICollectionView

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

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {

        itemWidth = max(0, collectionView.frame.size.width - 2 * (Constants.cellSpacing + Constants.cellPeekWidth))
        return CGSize(width: itemWidth, height: collectionView.frame.size.height - 10.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return Constants.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let leftAndRightInsets = Constants.cellSpacing + Constants.cellPeekWidth
        return UIEdgeInsets(top: 0, left: leftAndRightInsets, bottom: 0, right: leftAndRightInsets)
    }

    // MARK: - UIScrollView

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        currentScrollOffset = scrollView.contentOffset
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let target = targetContentOffset.pointee
        let currentScrollDistance = target.x - currentScrollOffset.x
        let coefficent = Int(max(-1, min(currentScrollDistance / Constants.scrollThreshold, 1)))
        let currentScrollIndex = Int(round(currentScrollOffset.x / itemWidth))
        let adjacentItemIndex = currentScrollIndex + coefficent
        let adjacentItemIndexFloat = CGFloat(adjacentItemIndex)
        let adjacentItemOffsetX = adjacentItemIndexFloat * (itemWidth + Constants.cellSpacing)
        targetContentOffset.pointee = CGPoint(x: adjacentItemOffsetX, y: target.y)
    }
}

