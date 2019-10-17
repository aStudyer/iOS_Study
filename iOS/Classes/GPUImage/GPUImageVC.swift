//
//  GPUImageVC.swift
//  iOS
//
//  Created by aStudyer on 2019/10/18.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

import UIKit

class GPUImageVC: BaseViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1. 获取修改的图片
        let sourceImage = UIImage(named: "girl.jpeg")!
        // 2.使用GPUImage处理高斯模糊效果
        // 2.1 对图形进行处理
        let picProcess = GPUImagePicture(image: sourceImage)
        // 2.2 添加滤镜
        let blurFilter = GPUImageGaussianBlurFilter()
        picProcess?.addTarget(blurFilter)
        // 2.3 处理图片
        blurFilter.useNextFrameForImageCapture()
        picProcess?.processImage()
        // 2.4 取出最新的图片
        let newImage = blurFilter.imageFromCurrentFramebuffer()
        // 3. 显示最新的图片
        imageView.image = newImage
    }
}
