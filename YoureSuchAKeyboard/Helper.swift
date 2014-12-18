//
//  Helper.swift
//  TKeyboard
//
//  Created by Harry Huang on 11/12/2014.
//  Copyright (c) 2014 HHH. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    class func getRandomColor() -> UIColor {
        
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    class func currentOrientationIsPortrait() -> Bool
    {
        var screenSize = UIScreen.mainScreen().bounds.size
        
        return screenSize.width < screenSize.height
    }
}