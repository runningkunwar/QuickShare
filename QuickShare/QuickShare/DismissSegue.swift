//
//  DismissSegue.swift
//  QuickShare
//
//  Created by Kunwar on 3/1/15.
//  Copyright (c) 2015 Kunwar. All rights reserved.
//

import UIKit

class DismissSegue: UIStoryboardSegue {
    override func perform() {
        if let presentingViewController: UIViewController = self.sourceViewController.presentingViewController {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
}
