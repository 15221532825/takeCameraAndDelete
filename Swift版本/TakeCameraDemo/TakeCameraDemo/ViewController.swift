//
//  ViewController.swift
//  TakeCameraDemo
//
//  Created by 飞翔 on 2019/12/23.
//  Copyright © 2019 飞翔. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var photoView:PhotoView = {
        let photoView = PhotoView.init()
        photoView.frame = self.view.bounds
        return photoView
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(photoView)
        
    }
    
}

