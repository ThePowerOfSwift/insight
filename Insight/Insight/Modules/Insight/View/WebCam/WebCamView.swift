//
//  WebCamView.swift
//  Insight
//
//  Created by Douglas Mandarino on 07/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit
import AVFoundation

class CamView: UIView, UIGestureRecognizerDelegate {
    
    static private let captureSession = AVCaptureSession()
    static private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    static private var input: AVCaptureDeviceInput?
    
    static func show(in superView: UIView) {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
            input = try AVCaptureDeviceInput(device: captureDevice)
            guard input != nil else { return }
            captureSession.addInput(input!)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = CGRect(x: 0, y: 0, width: 300, height: 169)
            captureSession.startRunning()
            guard let layer = videoPreviewLayer else { return }
            superView.layer.addSublayer(layer)
        } catch {
            return
        }
    }
    
    static func stop() {
        videoPreviewLayer?.removeFromSuperlayer()
        captureSession.stopRunning()
        guard input != nil else { return }
        captureSession.removeInput(input!)
    }
}
