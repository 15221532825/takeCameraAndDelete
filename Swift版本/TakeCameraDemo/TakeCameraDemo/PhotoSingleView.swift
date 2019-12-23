//
//  PhotoSingleView.swift
//  TakeCameraDemo
//
//  Created by 飞翔 on 2019/12/23.
//  Copyright © 2019 飞翔. All rights reserved.
//

import UIKit

protocol PhotoSingleViewDelegate {
    ///拍照更新
    func photoSingleViewPhotoUpdate(currentIndex:Int,model:PhotoModel)
    ///删除更新
    func photoSingleViewDeletePhoto(currentIndex:Int,model:PhotoModel)
}

class PhotoSingleView: UIView {

    lazy var photoButton:PhotoButton = {
        let button  = PhotoButton.createButton()
        button.model = PhotoModel.init()
        button.setImage(UIImage.init(named: "相机"), for: .normal)
        button.addTarget(self, action: #selector(photo), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton:UIButton = {
        let cancelButton  = UIButton.init(type: .custom)
        cancelButton.setImage(UIImage.init(named: "叉号"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelButton.adjustsImageWhenHighlighted = false
        return cancelButton
    }()
    
    ///记录当前下标
    var currentIndex:Int = 0
    var delegate:PhotoSingleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PhotoSingleView{
    
    func updateUI(isHiddenView:Bool,isHiddenCancel:Bool){
        
        self.isHidden = isHiddenView
        self.photoButton.isHidden = isHiddenView;
        self.cancelButton.isHidden = isHiddenCancel
    }
}

extension PhotoSingleView{
    
    func prepare()  {
        self.addSubview(photoButton)
        self.addSubview(cancelButton)
        photoButton.frame = self.bounds
        cancelButton.frame = CGRect.init(x: self.frame.size.width - 27, y: 0, width: 27, height: 27)
    }
}

extension PhotoSingleView{
    
    ///拍照 为了简单就直接从本地xcasset里面直接取照片
    @objc func photo(){
        
        photoButton.model?.image = UIImage.init(named: "\(self.currentIndex)")
        photoButton.setImage(UIImage.init(named: "\(self.currentIndex)"), for: .normal)
        if let photoDelegate = self.delegate{
            photoDelegate.photoSingleViewPhotoUpdate(currentIndex: self.currentIndex, model: photoButton.model!)
        }
    }
    
    ///删除
    @objc func cancel(){
        ///删除的时候 恢复默认图片
        photoButton.setImage(UIImage.init(named: "相机"), for: .normal)
        photoButton.model? = PhotoModel.init()
        if let photoDelegate = delegate{
            photoDelegate.photoSingleViewDeletePhoto(currentIndex: self.currentIndex, model: photoButton.model ?? PhotoModel.init())
        }
    }
}
