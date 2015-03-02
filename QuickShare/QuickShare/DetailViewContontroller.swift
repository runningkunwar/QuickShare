//
//  DetailViewContontroller.swift
//  QuickShare
//
//  Created by Kunwar on 3/1/15.
//  Copyright (c) 2015 Kunwar. All rights reserved.
//

import UIKit
import Photos

class DetailViewController: UIViewController {
    
    var photoAssets: PHAsset?
    @IBOutlet weak var imageView: UIImageView!
    var imageManager = PHCachingImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (photoAssets != nil) {
            self.imageManager.requestImageForAsset(photoAssets, targetSize: CGSize(width: 320, height: 320), contentMode: .AspectFill, options: nil) { image, info in
                self.imageView.image = image
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
