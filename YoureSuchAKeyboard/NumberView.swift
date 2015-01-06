//
//  NumberView.swift
//  YoureSuchA
//
//  Created by Harry Huang on 06/01/2015.
//  Copyright (c) 2015 HHH. All rights reserved.
//

import Foundation
import UIKit

protocol NumberViewDelegate : class
{
    func numberPressed(number:String?)
}

class NumberView : UIView {
    var numberOfButtons = 10
    var buttonBaseTag = 300
    
    weak var delegate:NumberViewDelegate?
    
    func setUpButtons()
    {
        for index in 0...9
        {
            var button:UIButton = UIButton()
            button.addTarget(self, action:"buttonTapped:" , forControlEvents: UIControlEvents.TouchDown)
            button.setTitle(String(index), forState: UIControlState.Normal)
            button.tag = buttonBaseTag + index
            button.backgroundColor = Helper.getRandomColor()
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
        self.delegate?.numberPressed(sender.titleLabel?.text)
    }

}
