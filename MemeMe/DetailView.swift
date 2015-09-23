//
//  DetailView.swift
//  MemeMe
//
//  Created by Guilherme Carvalho on 9/22/15.
//  Copyright © 2015 Guilherme Carvalho. All rights reserved.
//

import UIKit

class DetailView: UIViewController {
    

    @IBOutlet weak var memeImage: UIImageView!
    var memes: [Meme]!
    var memeId:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            memes = appDelegate.memes
            memeImage.image = memes[memeId].memedImage
      }

    @IBAction func dismissDetailVC(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
