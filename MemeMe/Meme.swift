//
//  Meme.swift
//  MemeMe
//
//  Created by Travis Baker on 2/20/17.
//  Copyright © 2017 Travis Baker. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    
    /// Retrieves all memes from the AppDelegate
    ///
    /// - Returns: array of all memes
    static func getAllMemes() -> [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
}
