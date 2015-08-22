//
//  Meme.swift
//  MemeMe
//
//  Created by Guilherme Carvalho on 8/20/15.
//  Copyright (c) 2015 Guilherme Carvalho. All rights reserved.
//

import Foundation
import UIKit

class Meme : NSObject {
    var topText:String = ""
    var bottomText:String = ""
    var originalImage:UIImage
    var memedImage:UIImage
    
    init(topText:String, bottomText:String, image:UIImage, memedImage:UIImage) {
        self.bottomText = ""
        self.topText = ""
        self.originalImage = image
        self.memedImage = memedImage
    }
}