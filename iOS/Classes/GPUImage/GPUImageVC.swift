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
    private lazy var image = UIImage(named: "girl.jpeg")!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
extension GPUImageVC{
    @IBAction func mohu(_ sender: UIButton) {
        // 1. 添加滤镜
        let filter = GPUImageGaussianBlurFilter()
        // 2.添加纹理
        filter.texelSpacingMultiplier = 5
        filter.blurRadiusInPixels = 5
        // 3. 取出最新的图片
        let newImage = processImage(filter: filter)
        // 5. 显示最新的图片
        imageView.image = newImage
    }
    @IBAction func hese(_ sender: UIButton) {
        let filter = GPUImageSepiaFilter()
        imageView.image = processImage(filter: filter)
    }
    @IBAction func katong(_ sender: UIButton) {
        let filter = GPUImageToonFilter()
        imageView.image = processImage(filter: filter)
    }
    @IBAction func sumiao(_ sender: UIButton) {
        let filter = GPUImageSketchFilter()
        imageView.image = processImage(filter: filter)
    }
    @IBAction func fudiao(_ sender: UIButton) {
        let filter = GPUImageEmbossFilter()
        imageView.image = processImage(filter: filter)
    }
}
extension GPUImageVC{
    private func processImage(filter: GPUImageFilter) -> UIImage? {
        let process = GPUImagePicture(image: image)
        // 1. 添加滤镜
        process?.addTarget(filter)
        // 2. 处理图片
        filter.useNextFrameForImageCapture()
        process?.processImage()
        // 3. 取出最新的图片
        return filter.imageFromCurrentFramebuffer()
    }
}
