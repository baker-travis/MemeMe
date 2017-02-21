//
//  ViewController.swift
//  MemeMe
//
//  Created by Travis Baker on 2/20/17.
//  Copyright © 2017 Travis Baker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   //MARK: Properties
   @IBOutlet weak var memeImageView: UIImageView!
   @IBOutlet weak var cameraButton: UIBarButtonItem!
   @IBOutlet weak var shareButton: UIBarButtonItem!
   @IBOutlet weak var topTextField: UITextField!
   @IBOutlet weak var bottomTextField: UITextField!
   @IBOutlet weak var titleBar: UINavigationBar!
   @IBOutlet weak var toolbar: UIToolbar!
   
   let defaultTextAttributes: [String:Any?] = [
      NSStrokeColorAttributeName: UIColor(ciColor: .black()),
      NSStrokeWidthAttributeName: -3.0,
      NSForegroundColorAttributeName: UIColor(ciColor: .white()),
      NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
   ]

   override func viewDidLoad() {
      super.viewDidLoad()
      
      cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
      titleBar.isTranslucent = true
      toolbar.isTranslucent = true
      shareButton.isEnabled = false
      topTextField.defaultTextAttributes = defaultTextAttributes
      topTextField.textAlignment = .center
      topTextField.delegate = self
      bottomTextField.defaultTextAttributes = defaultTextAttributes
      bottomTextField.textAlignment = .center
      bottomTextField.delegate = self
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      subscribeToKeyboardNotifications()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      unsubscribeFromKeyboardNotifications()
   }
   
   
   //MARK: IBActions
   @IBAction func pickFromAlbum(_ sender: Any) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .photoLibrary
      
      present(imagePicker, animated: true, completion: nil)
   }
   
   @IBAction func pickFromCamera(_ sender: Any) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .camera
      
      present(imagePicker, animated: true, completion: nil)
   }
   
   @IBAction func shareMeme(_ sender: Any) {
      let image = getMemedImage()
      let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
      activityVC.completionWithItemsHandler = { activityType, completed, returnedItems, error in
         self.saveImage(image)
         activityVC.dismiss(animated: true, completion: nil)
      }
      
      present(activityVC, animated: true, completion: nil)
   }
   
   @IBAction func cancelMemeEditor(_ sender: Any) {
      memeImageView.image = nil
      topTextField.text = "TOP"
      bottomTextField.text = "BOTTOM"
      
      shareButton.isEnabled = false
   }
   
   //MARK: Utility Functions
   func getMemedImage() -> UIImage {
      //Hide title bar and tool bar
      titleBar.isHidden = true
      toolbar.isHidden = true
      
      UIGraphicsBeginImageContext(self.view.frame.size)
      view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
      let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      
      //Show title bar and tool bar
      titleBar.isHidden = false
      toolbar.isHidden = false
      
      return memedImage
   }
   
   func saveImage(_ memedImage: UIImage) {
      let meme = Meme(withTopText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: memeImageView.image!, memedImage: memedImage)
      
      //TODO: Save this meme somewhere
   }
   
   func subscribeToKeyboardNotifications() {
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
   }
   
   func unsubscribeFromKeyboardNotifications() {
      NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
      NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
   }
   
   func keyboardWillShow(_ notification: Notification) {
//      view.frame.origin.y = getKeyboardHeight(notification) * -1
   }
   
   func keyboardWillHide(_ notification: Notification) {
      view.frame.origin.y = 0
   }
   
   func getKeyboardHeight(_ notification: Notification) -> CGFloat {
      let userInfo = notification.userInfo
      let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
      return keyboardSize.cgRectValue.height
   }
   
}

//MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
   func textFieldDidBeginEditing(_ textField: UITextField) {
      textField.textAlignment = .center
      textField.text = ""
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
}

//MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
         self.memeImageView.image = image
         shareButton.isEnabled = true
      }
      
      picker.dismiss(animated: true, completion: nil)
   }
   
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true, completion: nil)
   }
}

//MARK: UINavigationDelegate
extension ViewController: UINavigationControllerDelegate {
   override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
      super.dismiss(animated: flag, completion: completion)
   }
}

