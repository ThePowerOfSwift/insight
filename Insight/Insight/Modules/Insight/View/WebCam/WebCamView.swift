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
    
    private let captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var trayCenter: CGPoint? = .zero
    private var superViewFrame: CGRect = .zero
    private var width: CGFloat = 180
    private var height: CGFloat = 102
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupWebCam()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupWebCam()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func show(in superView: UIView) {
        self.superViewFrame = superView.frame
        if captureSession.inputs.isEmpty {
            configureDeviceInput()
            setFrame()
            configureVideoPreviewLayer()
            superView.addSubview(self)
        }
        setCamOrientation()
        hideOrShowView()
        captureSession.startRunning()
    }
    
    func stop() {
        hideOrShowView()
    }
    
    @objc private func orientationDidChange() {
        setCamOrientation()
    }
    
    private func setupWebCam() {
        configureGestures()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    private func configureVideoPreviewLayer() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = CGRect(origin: .zero, size: self.bounds.size)
        self.videoPreviewLayer?.isHidden = true
        self.isHidden = true
        setCamOrientation()
        guard let layer = videoPreviewLayer else { return }
        self.layer.addSublayer(layer)
    }
    
    private func setFrame() {
        let xPosition = self.superViewFrame.width - self.width - 44
        let yPosition = self.superViewFrame.height - self.height - 28
        self.frame = CGRect(x: xPosition, y: yPosition, width: self.width, height: self.height)
        self.trayCenter = self.center
    }
    
    private func configureDeviceInput() {
        guard let captureDevice = frontCameraDevice() else { return }
        let input = try? AVCaptureDeviceInput(device: captureDevice)
        guard input != nil else { return }
        captureSession.addInput(input!)
    }
    
    private func hideOrShowView() {
        guard let hidden = videoPreviewLayer?.isHidden else { return }
        videoPreviewLayer?.isHidden = !hidden
        self.isHidden = !hidden
    }
    
    private func frontCameraDevice() -> AVCaptureDevice? {
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front)
        return session.devices.compactMap({ $0 }).filter({ $0.position == .front }).first
    }
    
    private func setCamOrientation() {
        switch UIDevice.current.orientation {
        case .landscapeRight:
            videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
        default:
            videoPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        }
    }
    
    @objc private func moveWebCam(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        let xPoint = self.frame.midX + translation.x
        let yPoint = self.frame.midY + translation.y
        
        if isCamOutOfTheEdge(xPoint: xPoint, yPoint: yPoint) {
            self.center = CGPoint(x: xPoint, y: yPoint)
        }

        recognizer.setTranslation(.zero, in: self)
    }
    
    @objc private func resizeWebCam(pinch: UIPinchGestureRecognizer) {
        switch pinch.state {
        case .ended, .cancelled:
            pinch.scale = 1
            self.trayCenter = self.center
        default:
            self.transform = CGAffineTransform(scaleX: pinch.scale, y: pinch.scale)
        }
    }
    
    private func isCamOutOfTheEdge(xPoint: CGFloat, yPoint: CGFloat) -> Bool {
        return ( xPoint < self.superViewFrame.width && xPoint > 0 )
            || ( yPoint < self.superViewFrame.height && yPoint > 0 )
    }
    
    private func configureGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(moveWebCam(recognizer:)))
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(resizeWebCam(pinch:)))
        
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 2
        
        pan.delegate = self
        pinch.delegate = self
        
        self.addGestureRecognizer(pan)
        self.addGestureRecognizer(pinch)
        self.isUserInteractionEnabled = true
    }
}
