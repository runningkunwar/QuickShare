//
//  PhotoLocationViewController.swift
//  QuickShare
//
//  Created by Kunwar on 3/17/15.
//  Copyright (c) 2015 Kunwar. All rights reserved.
//

import UIKit
import Photos

//Location header with photos inside descending by date

class PhotoLocationViewController: UIViewController , PHPhotoLibraryChangeObserver{

    var images: PHFetchResult = PHFetchResult()
    var imageManager = PHCachingImageManager()
    var photoManager = PhotoManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var items = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        images = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        
        
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
        
        let locationImageDict = photoManager.locationImageDict();
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    // Mark - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as PhotoCollectionViewCell
        
        
        if var imageAsset = images.objectAtIndex(indexPath.item) as? PHAsset {
            self.imageManager.requestImageForAsset(imageAsset, targetSize: CGSize(width: 200, height: 200), contentMode: .AspectFill, options: nil) { image, info in
                cell.imageView.image = image
            }
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //Scale up/down item size to utilize maximum space
        let minimumInteritemSpacing = Float(self.flowLayout.minimumInteritemSpacing);
        var itemWidth = Float(self.flowLayout.itemSize.width)
        let itemHeight = Float(self.flowLayout.itemSize.height)
        var numberOfColumns = Float(Int(collectionView.width/itemWidth))
        
        var totalUnusedSpace: Float = collectionView.width - (numberOfColumns*itemWidth) - (numberOfColumns - 1)*minimumInteritemSpacing
        
        var unusedSpacePerItem: Float = totalUnusedSpace/numberOfColumns
        
        itemWidth = itemWidth + unusedSpacePerItem//scale up/down cell size to use extra space
        
        return CGSizeMake(CGFloat(itemWidth), CGFloat(itemHeight))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        //Storyboard did not set minimumLineSpacing
        return self.flowLayout.minimumLineSpacing
    }
    
    
    // MARK: - PHPhotoLibraryChangeObserver
    
    func photoLibraryDidChange(changeInstance: PHChange!) {
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let collectionViewCell = sender as PhotoCollectionViewCell
        var photoAsset: PHAsset?
        if let indexPath = self.collectionView.indexPathForCell(collectionViewCell) {
            photoAsset = images.objectAtIndex(indexPath.item) as? PHAsset
        }
        
        if segue.destinationViewController.title == "Detail" {
            let detailViewController: DetailViewController = segue.destinationViewController as DetailViewController
            detailViewController.photoAssets = photoAsset
        }
    }

}
