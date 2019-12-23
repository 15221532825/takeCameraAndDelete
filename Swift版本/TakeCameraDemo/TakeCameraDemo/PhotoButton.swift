//
//  PhotoButton.swift
//  TakeCameraDemo
//
//  Created by 飞翔 on 2019/12/23.
//  Copyright © 2019 飞翔. All rights reserved.
//

import UIKit

class PhotoButton: UIButton {
 
    var model:PhotoModel?
    
    class func createButton() -> PhotoButton{
        
        let button = PhotoButton.init(type: .custom)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.adjustsImageWhenHighlighted = false
        return button
    }
    
}
