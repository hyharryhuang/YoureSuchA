//
//  BottomBar.swift
//  Youre such A
//
//  Created by Harry Huang on 11/12/2014.
//  Copyright (c) 2014 HHH. All rights reserved.
//

import Foundation
import UIKit

protocol BottomBarDelegate : class
{
    func switchKeyboardPressed()
    func backspaceDown()
    func backspaceUp()
    func toggleNumberView()
}

class BottomBar : UIView
{
    let numberOfButtons = 3
    let buttonBaseTag:Int = 100
    
    weak var delegate:BottomBarDelegate?
    
    let titles:[String] = ["Switch", "123", "Backspace"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setUpButtons()
    {
        for index in 0...(numberOfButtons-1)
        {
            var button:UIButton = UIButton()

            if(index == numberOfButtons - 1)
            {
                let cancelEvents: UIControlEvents = UIControlEvents.TouchUpInside|UIControlEvents.TouchUpInside|UIControlEvents.TouchDragExit|UIControlEvents.TouchUpOutside|UIControlEvents.TouchCancel|UIControlEvents.TouchDragOutside
                
                button.addTarget(self.delegate?, action: "backspaceDown", forControlEvents: .TouchDown)
                
                button.addTarget(self.delegate?, action: "backspaceUp", forControlEvents: cancelEvents)
            } else
            {
                button.addTarget(self, action:"buttonTapped:" , forControlEvents: UIControlEvents.TouchUpInside)
            }
            button.tag = buttonBaseTag + index
            button.setTitle(self.titles[index], forState: UIControlState.Normal)
            button.titleLabel?.textAlignment = NSTextAlignment.Center
            
            self.addSubview(button)
        }
    }
    
    func setUpButtonFrames()
    {
        var buttonHeight:CGFloat = self.frame.size.height
        var buttonWidth:CGFloat = self.frame.size.width / CGFloat(numberOfButtons)
        
        for index in 0...(numberOfButtons-1)
        {
            var buttonTag = index + buttonBaseTag
            var button = self.viewWithTag(buttonTag) as? UIButton
            
            button?.frame = CGRect(x: buttonWidth * CGFloat(index) , y: 0, width: buttonWidth, height: buttonHeight)
        }
    }
    
    func buttonTapped(sender:UIButton)
    {
        var actualButtonTag = sender.tag - buttonBaseTag
        
        switch actualButtonTag {
        case 0:
            self.delegate?.switchKeyboardPressed()
        case 1:
                self.delegate?.toggleNumberView()
                flipNumberButtonTitle()
        default:
            break
        }
    }
    
    func flipNumberButtonTitle()
    {
        var button = self.viewWithTag(buttonBaseTag + 1) as? UIButton
        
        if(button?.titleLabel?.text == "123")
        {
            button?.setTitle("YSA", forState: UIControlState.Normal)
        } else
        {
            button?.setTitle("123", forState: UIControlState.Normal)
        }
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}