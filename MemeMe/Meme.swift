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
   var topText: String
   var bottomText: String
   var originalImage: UIImage
   var memedImage: UIImage
   
   init(withTopText topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
      self.topText = topText
      self.bottomText = bottomText
      self.originalImage = originalImage
      self.memedImage = memedImage
   }
}
