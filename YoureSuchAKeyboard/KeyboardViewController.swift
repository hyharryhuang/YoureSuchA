//
//  KeyboardViewController.swift
//  YoureSuchAKeyboard
//
//  Created by Harry Huang on 18/12/2014.
//  Copyright (c) 2014 HHH. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {


    var nouns:[String] = []
    
    var youreAButton:UIButton!
    var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }
    
    func setUpNouns()
    {
        if(self.nouns.count == 0)
        {
            let bundle = NSBundle.mainBundle()
            let pathNav = bundle.pathForResource("nouns", ofType: "txt")
            
            if let aStreamReader = StreamReader(path: pathNav!) {
                while let line = aStreamReader.nextLine() {
                    self.nouns.append(line)
                }
                // You can close the underlying file explicitly. Otherwise it will be
                // closed when the reader is deallocated.
                aStreamReader.close()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpNouns()
//        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
//    
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
//    
//        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
//        
//        self.view.addSubview(self.nextKeyboardButton)
//    
//        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
//        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
//        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setUpViews()
    }
    
    var viewsSetUp = false
    func setUpViews()
    {
        if(!viewsSetUp)
        {
            self.youreAButton = UIButton(frame: CGRectZero)
            self.youreAButton.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.youreAButton.tag = 2
            self.youreAButton.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(self.youreAButton)
            self.youreAButton.setTitle("You're such a", forState: UIControlState.Normal)
            
            self.view.addConstraint(NSLayoutConstraint(item: self.youreAButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 10))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.youreAButton, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 50))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.youreAButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -50))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.youreAButton, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: -50))
            
            self.youreAButton.backgroundColor = Helper.getRandomColor()
            viewsSetUp = true
        }
    }
    
    func buttonPressed(sender:UIButton)
    {
        switch sender.tag
        {
        case 2:
                if(nouns.count > 0)
                {
                    let diceRoll = Int(arc4random_uniform(UInt32(nouns.count)))
                    insertText("You're such a \(self.nouns[diceRoll])!");
                    self.youreAButton.backgroundColor = Helper.getRandomColor()
                }

        default: break

        }
    }
    
    func insertText(text:String)
    {
        var proxy = self.textDocumentProxy as UITextDocumentProxy

        proxy.insertText(text)
    }
}
