//
//  PhotoView.swift
//  TakeCameraDemo
//
//  Created by 飞翔 on 2019/12/23.
//  Copyright © 2019 飞翔. All rights reserved.
//

import UIKit

class PhotoView: UIView{
    
    ///存放模型的数组
    lazy var photoAry:[PhotoModel] = {
        
        var array =  [PhotoModel]()
        for index in 0..<PHOTO_COUNT{
            var model = PhotoModel.init()
            array.append(model)
        }
        return array
    }()
    ///存放子控件的数组
    lazy var photoSingleAry:[PhotoSingleView] = {
        
        var singleAry = [PhotoSingleView]()
        return singleAry
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoView{
    
    func prepare() {
        
        ///添加子控件
        let width = (Int(SCREEN_WIDTH) - Int((PHOTO_COUNT + 1) * margin))/PHOTO_COUNT
        let height = width;
        for index in 0..<PHOTO_COUNT{
            
            let rect = CGRect.init(x: index * (width + margin) + margin, y:200, width: width, height: height)
            let singleView = PhotoSingleView.init(frame: rect)
            singleView.currentIndex = index
            singleView.delegate = self
            if index==0 {
                
                singleView.updateUI(isHiddenView: false, isHiddenCancel: true)
                
            }else{
                singleView.updateUI(isHiddenView:true, isHiddenCancel: true)
            }
            
            self.addSubview(singleView)
            self.photoSingleAry.append(singleView)
        }
    }
}

extension PhotoView:PhotoSingleViewDelegate{
    ///拍照更新
    func photoSingleViewPhotoUpdate(currentIndex: Int, model: PhotoModel) {
        if (model.image != nil) {
            ///更新视图
            let singleView = self.photoSingleAry[currentIndex]
            singleView.updateUI(isHiddenView: false, isHiddenCancel: false)
            self.photoAry[currentIndex] = model
        }
        ///更新视图
        if currentIndex < PHOTO_COUNT - 1{
            let anotherSingleView = self.photoSingleAry[currentIndex + 1]
            anotherSingleView.updateUI(isHiddenView: false, isHiddenCancel: true)
        }
    }
    
    ///删除更新
    func photoSingleViewDeletePhoto(currentIndex: Int, model: PhotoModel) {
        self.photoAry.remove(at: currentIndex)
        self.photoAry.append(model)
        var alreadyCount = 0
        for index in 0..<PHOTO_COUNT-1 {
            let model = self.photoAry[index]
            if  model.image != nil {
                alreadyCount += 1
            }
        }
        
        if alreadyCount <= PHOTO_COUNT - 1 {
            if alreadyCount > 0 {
                for index in 0..<alreadyCount {
                    let model = self.photoAry[index]
                    let newSingleView = self.photoSingleAry[index]
                    newSingleView.photoButton.setImage(model.image, for: .normal)
                }
                for index in alreadyCount...PHOTO_COUNT-1 {
                    ///更新视图
                    let newSingleView = self.photoSingleAry[index]
                    newSingleView.photoButton.setImage(UIImage.init(named: "相机"), for: .normal)
                    newSingleView.updateUI(isHiddenView: true, isHiddenCancel: true)
                }
                
                let anotherSingleView =  self.photoSingleAry[alreadyCount]
                anotherSingleView.updateUI(isHiddenView: false, isHiddenCancel: true)
            }else{
                
                for index in 0..<PHOTO_COUNT{
                    let singleView =  self.photoSingleAry[index]
                    singleView.currentIndex = index
                    singleView.delegate = self
                    if index==0 {
                        
                        singleView.updateUI(isHiddenView: false, isHiddenCancel: true)
                        
                    }else{
                        singleView.updateUI(isHiddenView:true, isHiddenCancel: true)
                    }
                }
            }
        }
    }
}
