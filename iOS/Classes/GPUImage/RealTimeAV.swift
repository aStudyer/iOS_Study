//
//  RealTimeAV.swift
//  iOS
//
//  Created by aStudyer on 2019/10/19.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

import UIKit

class RealTimeAV: BaseViewController {
    private lazy var filter: GPUImageBrightnessFilter = {
        let filter = GPUImageBrightnessFilter()
        filter.brightness = 0.4
        return filter
    }()
    private lazy var camera: GPUImageVideoCamera? = {
        let camera = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .front)
        camera?.outputImageOrientation = .portrait
        camera?.horizontallyMirrorRearFacingCamera = true
        camera?.horizontallyMirrorFrontFacingCamera = true
        camera?.delegate = self
        return camera
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        camera?.addTarget(filter)
        
        let showView = GPUImageView(frame: UIScreen.main.bounds)
        view.insertSubview(showView, at: 0)
        filter.addTarget(showView)
        
        // 开始捕捉画面
        camera?.startCapture()
    }
}
extension RealTimeAV: GPUImageVideoCameraDelegate{
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        print("采集到画面")
    }
}
