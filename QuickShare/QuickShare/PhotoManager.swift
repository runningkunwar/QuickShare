//
//  PhotoManager.swift
//  QuickShare
//
//  Created by Kunwar on 3/6/15.
//  Copyright (c) 2015 Kunwar. All rights reserved.
//

import Foundation
import Photos
import CoreLocation
import MapKit

class PhotoManager: NSObject, PHPhotoLibraryChangeObserver {
    var allImages: PHFetchResult?
    var locationImages: [String: [PHAsset]] = ["": []]
    var dateImages: [NSDate: [PHAsset]] = [NSDate() : []]
    var imageManager = PHCachingImageManager()
    let geoCoder = CLGeocoder()

    func allPhotos() -> PHFetchResult {
        self.allImages = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        return self.allImages!
    }
    
    func locationImageDict() -> [String: [PHAsset]] {
        var imageDict = ["": [PHAsset()]]
    
//        var assetResult: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Moment, subtype: PHAssetCollectionSubtype.Any, options: nil)
//        var result = PHAssetCollection.fetchMomentsWithOptions(nil)
//        
//        result.enumerateObjectsUsingBlock { (object: AnyObject!, idx: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
//            if let assetCollection = object as? PHAssetCollection {
//                 print(assetCollection.localizedLocationNames)
//                
//                let locationName = assetCollection.localizedLocationNames[0]
//                imageDict[locationName] += assetCollection.
//            }
//        }
        
        return imageDict
    }
    
    func photoMoments() -> PHFetchResult {
        var assetResult: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Moment, subtype: PHAssetCollectionSubtype.Any, options: nil)
        return assetResult
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    
    func photoLibraryDidChange(changeInstance: PHChange!) {
        
    }
    
}
