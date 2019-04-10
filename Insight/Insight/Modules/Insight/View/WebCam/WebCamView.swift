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
        guard let captureDevice = frontCameraDevice() else { return }
        input = try? AVCaptureDeviceInput(device: captureDevice)
        guard input != nil else { return }
        captureSession.addInput(input!)
        configureVideoPreviewLayer(in: superView)
        captureSession.startRunning()
    }
    
    static func stop() {
        videoPreviewLayer?.removeFromSuperlayer()
        captureSession.stopRunning()
        guard input != nil else { return }
        captureSession.removeInput(input!)
    }
    
    static private func frontCameraDevice() -> AVCaptureDevice? {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front)
        return session.devices.compactMap({ $0 }).filter({ $0.position == .front }).first
    }
    
    static private func configureVideoPreviewLayer(in superView: UIView) {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = CGRect(x: 150, y: superView.frame.height/2, width: 150, height: 85)
        setCamOrientation()
        guard let layer = videoPreviewLayer else { return }
        superView.layer.addSublayer(layer)
    }
    
    static private func setCamOrientation() {
        switch UIDevice.current.orientation {
        case .landscapeRight:
            videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
        default:
            videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        }
    }
}
