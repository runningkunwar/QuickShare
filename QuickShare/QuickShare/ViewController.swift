//
//  ViewController.swift
//  QuickShare
//
//  Created by Kunwar on 2/17/15.
//  Copyright (c) 2015 Kunwar. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, PHPhotoLibraryChangeObserver {
    
    var images: PHFetchResult = PHFetchResult()
    var imageManager = PHCachingImageManager()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var items = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        images = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as PhotoCollectionViewCell
        

        if var imageAsset = images.objectAtIndex(indexPath.item) as? PHAsset {
            self.imageManager.requestImageForAsset(imageAsset, targetSize: CGSize(width: 320, height: 320), contentMode: .AspectFill, options: nil) { image, info in
                cell.imageView.image = image
            }
        }
        
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let itemSpacing: Float = 10//fixed in storyboard
        var itemWidth: Float = 100.0
        var numberOfColumns: Float = Float(Int(collectionView.width/itemWidth))
        var totalUnusedSpace: Float = collectionView.width - Float(numberOfColumns*itemWidth) - (numberOfColumns - 1)*itemSpacing
        
        var unusedSpace: Float = totalUnusedSpace/numberOfColumns
        
        itemWidth = itemWidth + unusedSpace - 1//increase cell size to use extra space

        return CGSizeMake(CGFloat(itemWidth), CGFloat(itemWidth))
    }

    // MARK: - PHPhotoLibraryChangeObserver
        
    func photoLibraryDidChange(changeInstance: PHChange!) {
    
    }
 

}
