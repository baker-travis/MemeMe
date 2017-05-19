//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Travis Baker on 5/10/17.
//  Copyright © 2017 Travis Baker. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMemes()
    }
    
    /// Loads memes
    func getMemes() {
        memes = Meme.getAllMemes()
        collectionView?.reloadData()
    }
    
    /// Prepares the cell layout for the collection view
    func setupFlowLayout() {
        let space = CGFloat(3)
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        
        let width = calculateCellDimensions(cellSpacing: space, minCellWidth: 90.0)
        flowLayout.itemSize = CGSize(width: width, height: width)
    }
    
    /// Calculates actual cell width based on spacing between cells and a specified
    /// minimum cell width. It will first maximize the number of cells per row, and then
    /// maximize the width of each cell.
    ///
    /// - Parameters:
    ///   - space: the space between cells
    ///   - minCellWidth: the smallest you want the width of your cell to be
    /// - Returns: the maximum width of each cell
    func calculateCellDimensions(cellSpacing space: CGFloat, minCellWidth: CGFloat) -> CGFloat {
        let spaceSize: CGFloat = 3.0
        let minCellWidth: CGFloat = 90.0
        let deviceWidth = self.view.frame.size.width
        
        // how many we can fit across
        let across = Int((deviceWidth + spaceSize) / (spaceSize + minCellWidth))
        
        let width = (deviceWidth - (spaceSize * (CGFloat(across) - 1))) / CGFloat(across)
        
        return width
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        
        // setup the cell
        cell.memeImageView.image = memes[indexPath.row].memedImage
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailViewController.memedImage = memes[indexPath.row].memedImage
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
