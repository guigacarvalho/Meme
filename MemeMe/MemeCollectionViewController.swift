//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Guilherme Carvalho on 8/24/15.
//  Copyright (c) 2015 Guilherme Carvalho. All rights reserved.
//

import UIKit

class MemeCollectionViewController:UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var memesCollectionView: UICollectionView!
    var memes: [Meme]!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        memesCollectionView.reloadData()
    }
    
    @IBOutlet weak var memeFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat = 0.0
        let flowWidth = (self.view.frame.size.width) / 3.0
        
        let flowHeight = (self.view.frame.size.height) / 3.0
        memeFlowLayout.minimumLineSpacing = space
        memeFlowLayout.minimumInteritemSpacing = space
        memeFlowLayout.itemSize = CGSizeMake(flowWidth, flowWidth)

        let createMemeButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addBarButtonItemClicked" )
        navigationItem.rightBarButtonItem = createMemeButton
    }
    
    func addBarButtonItemClicked() {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("addMeme") as! ViewController
        navigationController?.pushViewController(addMemeVC, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var item = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        print(indexPath.row)
        var meme = memes[indexPath.row]
        item.memeImageView.image = meme.memedImage
        return item
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeVC = storyboard?.instantiateViewControllerWithIdentifier("addMeme") as! ViewController
        memeVC.memeId = indexPath.row        
        navigationController?.pushViewController(memeVC, animated: true)
        
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
}
