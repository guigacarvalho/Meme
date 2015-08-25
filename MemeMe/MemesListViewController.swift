//
//  MemesListViewController.swift
//  MemeMe
//
//  Created by Guilherme Carvalho on 8/24/15.
//  Copyright (c) 2015 Guilherme Carvalho. All rights reserved.
//

import UIKit

class MemesListViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        print (memes.count)
    }
    
    override func viewDidLoad() {
        let createMemeButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addBarButtonItemClicked" )
        navigationItem.rightBarButtonItem = createMemeButton
    }
    
    func addBarButtonItemClicked() {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("addMeme") as! ViewController
        navigationController?.pushViewController(addMemeVC, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (memes.count)
        return memes.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeView") as! UITableViewCell
        var meme = memes[indexPath.row]
        cell.imageView?.image = meme.originalImage
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        return cell
    }
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        return
//    }
}
