//
//  KeyboardViewController.swift
//  YoureSuchAKeyboard
//
//  Created by Harry Huang on 18/12/2014.
//  Copyright (c) 2014 HHH. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, BottomBarDelegate, NumberViewDelegate {
    
    
    var nouns:[String] = []
    var bottomBar:BottomBar!
    var numberView:NumberView!
    var youreAButton:UIButton!
    
    let vowels = ["a", "e", "i", "o", "u"]
    let backspaceDelay: NSTimeInterval = 0.5
    let backspaceRepeat: NSTimeInterval = 0.07
    
    var backspaceActive: Bool {
        get {
            return (backspaceDelayTimer != nil) || (backspaceRepeatTimer != nil)
        }
    }
    var backspaceDelayTimer: NSTimer?
    var backspaceRepeatTimer: NSTimer?
    
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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setUpViews()
    }
    
    override func viewDidLayoutSubviews() {
        if view.bounds == CGRectZero {
            return
        }
        
        layoutViews()
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
            self.youreAButton.setTitle("You're such a...", forState: UIControlState.Normal)
            
            self.view.addConstraint(NSLayoutConstraint(item: self.youreAButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.youreAButton, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.youreAButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -50))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.youreAButton, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0))
            
            self.youreAButton.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
            self.youreAButton.backgroundColor = Helper.getRandomColor()
            
            //Number view
            self.numberView = NumberView(frame: CGRectZero)
            self.numberView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.numberView.delegate = self
            self.numberView.setUpButtons()
            self.numberView.alpha = 0
            self.view.addSubview(self.numberView)
            
            self.view.addConstraint(NSLayoutConstraint(item: self.numberView, attribute: .Top, relatedBy: .Equal, toItem: self.youreAButton, attribute: .Top, multiplier: 1.0, constant: 0.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.numberView, attribute: .Leading, relatedBy: .Equal, toItem: self.youreAButton, attribute: .Leading, multiplier: 1.0, constant: 0.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.numberView, attribute: .Bottom, relatedBy: .Equal, toItem: self.youreAButton, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.numberView, attribute: .Trailing, relatedBy: .Equal, toItem: self.youreAButton, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
            
            viewsSetUp = true
            
            //Bottom bar
            self.bottomBar = BottomBar(frame: CGRectZero)
            self.bottomBar.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.bottomBar.delegate = self
            self.bottomBar.setUpButtons()
            self.view.addSubview(self.bottomBar)
            
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomBar, attribute: NSLayoutAttribute.Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomBar, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomBar, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomBar, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
            
            viewsSetUp = true
        }
    }
    
    func layoutViews()
    {
        if(viewsSetUp)
        {
            self.bottomBar.setUpButtonFrames()
            self.numberView.setUpButtonFrames()
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
                var noun = self.nouns[diceRoll]
                var firstChar = String(Array(noun)[0])
                var textToInsert = "You're such a \(noun)!"
                
                if contains(self.vowels, firstChar.lowercaseString) {
                    textToInsert = "You're such an \(noun)!"
                }
                
                insertText(textToInsert)
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
    
    func switchKeyboardPressed()
    {
        self.advanceToNextInputMode()
    }
    
    func cancelBackspaceTimers() {
        self.backspaceDelayTimer?.invalidate()
        self.backspaceRepeatTimer?.invalidate()
        self.backspaceDelayTimer = nil
        self.backspaceRepeatTimer = nil
    }
    
    func backspaceDown() {
        self.cancelBackspaceTimers()
        
        if let textDocumentProxy = self.textDocumentProxy as? UIKeyInput {
            textDocumentProxy.deleteBackward()
        }
        
        // trigger for subsequent deletes
        self.backspaceDelayTimer = NSTimer.scheduledTimerWithTimeInterval(backspaceDelay - backspaceRepeat, target: self, selector: Selector("backspaceDelayCallback"), userInfo: nil, repeats: false)
    }
    
    func backspaceUp() {
        self.cancelBackspaceTimers()
    }
    
    func backspaceDelayCallback() {
        self.backspaceDelayTimer = nil
        self.backspaceRepeatTimer = NSTimer.scheduledTimerWithTimeInterval(backspaceRepeat, target: self, selector: Selector("backspaceRepeatCallback"), userInfo: nil, repeats: true)
    }
    
    func backspaceRepeatCallback() {
        
        if let textDocumentProxy = self.textDocumentProxy as? UIKeyInput {
            textDocumentProxy.deleteBackward()
        }
    }
    
    func toggleNumberView() {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.numberView.alpha = self.numberView.alpha == 1 ? 0 : 1
            self.youreAButton.alpha = self.numberView.alpha == 1 ? 0 : 1
        })
    }
    
    //NumberViewDelegate
    func numberPressed(number: String?) {
        if let numberStr = number? {
            insertText(numberStr)
        }
    }
}