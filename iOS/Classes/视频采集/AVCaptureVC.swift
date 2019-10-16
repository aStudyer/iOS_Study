//
//  AVCaptureVC.swift
//  iOS
//
//  Created by aStudyer on 2019/10/17.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

import AVFoundation

class AVCaptureVC: BaseViewController {
    // MARK: - 懒加载
    private lazy var session: AVCaptureSession = AVCaptureSession()
    /// 视频输出
    private lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let videoDataOutput = AVCaptureVideoDataOutput()
        let queue = DispatchQueue.global()
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        return videoDataOutput
    }()
    // MARK: - 系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.初始化视频的输入&输出
        initVideoInputOutput()
        // 2.初始化音频的输入&输出
        initAudioInputOutput()
        // 3.初始化一个预览图层
        initPreviewLayer()
    }
}
// MARK: - 音视频采集
extension AVCaptureVC {
    @IBAction func startCapture(_ sender: UIButton) {
        session.startRunning()
    }
    @IBAction func stopCapture(_ sender: UIButton) {
        session.stopRunning()
    }
}
// MARK: - 初始化方法
extension AVCaptureVC {
    private func initVideoInputOutput() {
        // 1.初始化视频的输入
        guard let device = (AVCaptureDevice.devices().filter{ $0.position == .front }.first) else {
            return
        }
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        // 2.添加输入输出
        addCaptureToSession(input: input, output: videoDataOutput)
    }
    private func initAudioInputOutput() {
        // 1.初始化音频的输入
        guard let device = AVCaptureDevice.default(for: .audio) else {
            return
        }
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        // 2.初始化视频的输出
        let output = AVCaptureAudioDataOutput()
        let queue = DispatchQueue.global()
        output.setSampleBufferDelegate(self, queue: queue)
        // 3.添加输入输出
        addCaptureToSession(input: input, output: output)
    }
    private func initPreviewLayer () {
        // 1.创建预览图层
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        // 2.设置frmae
        previewLayer.frame = UIScreen.main.bounds
        // 3.添加预览图层
        view.layer.addSublayer(previewLayer)
    }
}
// MARK: - 代理方法
extension AVCaptureVC : AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if videoDataOutput.connection(with: .video) == connection {
            print("采集到视频数据")
        }else{
            print("采集到音频数据")
        }
    }
}
// MARK: - 辅助方法
extension AVCaptureVC {
    private func addCaptureToSession(input: AVCaptureInput, output: AVCaptureOutput) {
        session.beginConfiguration()
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        session.commitConfiguration()
    }
}
