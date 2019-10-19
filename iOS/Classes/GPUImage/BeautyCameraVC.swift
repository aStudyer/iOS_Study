//
//  BeautyCameraVC.swift
//  iOS
//
//  Created by aStudyer on 2019/10/18.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

import UIKit
import AVFoundation

class BeautyCameraVC: BaseViewController {
    private lazy var filter: GPUImageBrightnessFilter = {
        let filter = GPUImageBrightnessFilter()
        filter.brightness = 0.4
        return filter
    }()
    private lazy var camera: GPUImageStillCamera? = {
       let camera = GPUImageStillCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .front)
        camera?.outputImageOrientation = .portrait
        camera?.horizontallyMirrorRearFacingCamera = true
        camera?.horizontallyMirrorFrontFacingCamera = true
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
extension BeautyCameraVC {
    @IBAction func takePhoto(_ sender: UIButton) {
        camera?.capturePhotoAsImageProcessedUp(toFilter: filter, withCompletionHandler: { (image, error) in
            guard let image = image else {
                return
            }
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.didFinishSaving(image:error:contextInfo:)), nil)
        })
    }
    @objc private func didFinishSaving(image: UIImage?, error: NSError?, contextInfo: AnyObject?) {
        var title: String
        if let error = error {
            title = error.localizedDescription
        }else{
            title = "保存成功"
        }
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
