//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Guilherme Carvalho on 8/19/15.
//  Copyright (c) 2015 Guilherme Carvalho. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var memes: [Meme]!
    var memeId:Int!
    
    // Styles for the meme text
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor(white: 1, alpha: 1.0),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (memeId == nil) {
        // Setting up the view
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        } else {
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            memes = appDelegate.memes
            topTextField.text = memes[memeId].topText
            bottomTextField.text = memes[memeId].bottomText
            memeImage.image = memes[memeId].originalImage
            
        }
        
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        subscribeToKeyboardNotifications()
        shareButton.enabled = false


    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        tabBarController?.tabBar.hidden = false
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        let picker:UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    @IBAction func shareMeme(sender: AnyObject) {
        let meme = self.save()
        let image:UIImage = meme.memedImage
        let shareViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        presentViewController(shareViewController, animated: false, completion:nil)
        shareViewController.completionWithItemsHandler = {(activityType: String?, completed: Bool, returnedItems: [AnyObject]?, error: NSError?) in
            if (completed) {
                let object = UIApplication.sharedApplication().delegate
                let appDelegate = object as! AppDelegate
                appDelegate.memes.append(meme)
            }
            print ("Shared video activity: \(activityType)")
            self.navigationController?.popToRootViewControllerAnimated(true)
        }

    }
    @IBAction func takeAPicture(sender: AnyObject) {
        let picker:UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        memeImage.image = image
        shareButton.enabled = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification){
        if (!topTextField.isFirstResponder()) {
            let keyboardHeight = getKeyboardHeight(notification)
            view.frame.origin.y = -(keyboardHeight)
        }
    }
    func keyboardWillHide(notification: NSNotification){
        view.frame.origin.y = 0.0
    }
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    func generateMemedImage() -> UIImage {
        
        hideBarsForPic()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        showBarsAfterPic()
        
        return memedImage
    }
    func hideBarsForPic() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        toolBar.hidden = true
    }
    func showBarsAfterPic() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        toolBar.hidden = false
        
    }
    func save() -> Meme {
        //Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImage.image!, memedImage: generateMemedImage())
        return meme
    }

}

