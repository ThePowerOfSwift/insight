//
//  InsightInteractor.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import ReplayKit


// MARK: - Protocols

protocol InsightRecorderInteractorProtocol {
    func startOrStopRecording()
    func startOrStopBroadcast()
}

protocol InsightRecorderInteractorDelegate: class {
    func startRecording()
    func stopRecording()
    func startBroadcast()
    func broadcastEnded()
}


// MARK: - InsightInteractor

final class InsightRecorderInteractor {
    
    private weak var delegate: InsightRecorderInteractorDelegate?
    private weak var documentDelegate: InsightDocumentInteractorDelegate?
    
    private let broadcastController = RPBroadcastController()
    private var pdfDocument: PDFDocument?
    
    init() {}
    
    func setupInteractor(with output: InsightRecorderInteractorDelegate) {
        self.delegate = output
    }
}


// MARK: - InsightInteractorProtocol

extension InsightRecorderInteractor: InsightRecorderInteractorProtocol {
    
    func startOrStopBroadcast() {
        self.broadcastController.isBroadcasting ? stopBroadcast() : startBroadcast()
    }
    
    func startOrStopRecording() {
        RPScreenRecorder.shared().isRecording ? stopRecording() : startRecording()
    }
    
    private func startBroadcast() {
        self.delegate?.startBroadcast()
    }
    
    private func stopBroadcast() {
        self.broadcastController.finishBroadcast { [weak self] error in
            DispatchQueue.main.async {
                guard error == nil else { return }
                self?.delegate?.broadcastEnded()
            }
        }
    }
    
    private func startRecording() {
        self.delegate?.startRecording()
    }
    
    private func stopRecording() {
        self.delegate?.stopRecording()
    }
}
