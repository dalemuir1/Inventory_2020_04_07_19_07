//
//  ScrollingFormViewController.swift
//  Inventory
//
//  Created by dalemuir on 10/13/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

class ScrollingFormViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var activeFieldRect: CGRect?
    var keyboardRect: CGRect?
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.registerForKeyboardNotifications()
        for view in self.view.subviews {
            if view is UITextView {
                let tv = view as! UITextView
                tv.delegate = self
            } else if view is UITextField {
                let tf = view as! UITextField
                tf.delegate = self
            }
        }
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.isScrollEnabled = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(self.view)
        self.view = scrollView
    }

    func recursiveRegisterForKeyboardNotifications(subView: UIView){
        
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        //scrollView.sizeToFit()
        //scrollView.contentSize = scrollView.frame.size
        super.viewDidLayoutSubviews()
    }
    
    deinit {
        self.deregisterFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(ScrollingFormViewController.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ScrollingFormViewController.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification)
    {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        keyboardRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        adjustForKeyboard()
    }
    
    
    @objc func keyboardWillBeHidden(notification: NSNotification)
    {
        keyboardRect = nil
        adjustForKeyboard()
    }
    
    func adjustForKeyboard() {
        if keyboardRect != nil && activeFieldRect != nil {
            let aRect : CGRect = scrollView.convert(activeFieldRect!, to: nil)
            let aPoint: CGPoint = CGPoint(x: aRect.origin.x, y: aRect.maxY)
            if keyboardRect!.contains(aPoint)
                //contains(aPoint)
                //(CGPoint(aRect.origin.x, aRect.maxY)))
            {
                scrollView.isScrollEnabled = true
                let contentInsets : UIEdgeInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyboardRect!.size.height, right: 0.0)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
                scrollView.scrollRectToVisible(activeFieldRect!, animated: true)
            }
        } else {
            let contentInsets : UIEdgeInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            scrollView.isScrollEnabled = false
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        activeFieldRect = textView.frame
        adjustForKeyboard()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        activeFieldRect = nil
        adjustForKeyboard()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeFieldRect = textField.frame
        adjustForKeyboard()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        activeFieldRect = nil
        adjustForKeyboard()
    }
    
}
