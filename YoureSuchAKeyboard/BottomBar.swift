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
}

class BottomBar : UIView
{
    let numberOfButtons = 2
    let buttonBaseTag:Int = 100
    
    weak var delegate:BottomBarDelegate?
    
    let titles:[String] = ["Switch Keyboard", "Backspace"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setUpButtons()
    {
        for index in 0...(numberOfButtons-1)
        {
            var button:UIButton = UIButton()

            if(index == 1)
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
        default:
            break
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}