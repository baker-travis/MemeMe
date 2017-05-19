//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Travis Baker on 5/17/17.
//  Copyright © 2017 Travis Baker. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var memedImage: UIImage!
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeImageView.image = memedImage
    }
}
