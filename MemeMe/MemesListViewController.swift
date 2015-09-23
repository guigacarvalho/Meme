//
//  MemesListViewController.swift
//  MemeMe
//
//  Created by Guilherme Carvalho on 8/24/15.
//  Copyright (c) 2015 Guilherme Carvalho. All rights reserved.
//

import UIKit

class MemesListViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var memesTableView: UITableView!
    var memes: [Meme]!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        memesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        let createMemeButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addBarButtonItemClicked" )
        navigationItem.rightBarButtonItem = createMemeButton
    }
    
    func addBarButtonItemClicked() {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("addMeme") as! MemeEditorViewController
        navigationController?.pushViewController(addMemeVC, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (memes.count)
        return memes.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeView") as UITableViewCell!
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.originalImage
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeVC = storyboard?.instantiateViewControllerWithIdentifier("memeDetail") as! DetailView
        memeVC.memeId = indexPath.row
        navigationController?.pushViewController(memeVC, animated: true)
    }
}
