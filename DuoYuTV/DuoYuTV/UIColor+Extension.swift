//
//  UIColor+Extension.swift
//  DuoYuTV
//
//  Created by apple on 16/10/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

extension UIColor{

    //MARK:- 遍历构造器
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
