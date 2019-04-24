//
//  InsightInteractor.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import ReplayKit


final class InsightInteractor {
    
    private weak var output: InsightInteractorOutputProtocol?
    
    private let broadcastController = RPBroadcastController()
    private let recorder = RPScreenRecorder.shared()
    private var pdfDocument: PDFDocument?
    
    init() {}
    
    func setupInteractor(with output: InsightInteractorOutputProtocol) {
        self.output = output
    }
}

extension InsightInteractor: InsightInteractorProtocol {
    
    func startOrStopBroadcast() {
        self.broadcastController.isBroadcasting ? stopBroadcast() : startBroadcast()
    }
    
    func startOrStopRecording() {
        self.recorder.isRecording ? stopRecording() : startRecording()
    }
    
    func fetchPresentation(url: URL) {
        DispatchQueue.global().async {
            guard let document = CGPDFDocument(url as CFURL) else {
                self.output?.didFailFetchingDocument()
                return
            }
            DispatchQueue.main.async {
                self.pdfDocument = PDFDocumentMapper.make(from: document)
                self.output?.didFetchDocument(document: self.pdfDocument!)
            }
        }
    }
    
    private func startBroadcast() {
        self.output?.startBroadcast()
    }
    
    private func stopBroadcast() {
        self.broadcastController.finishBroadcast { [unowned self] error in
            DispatchQueue.main.async {
                guard error == nil else { return }
                self.output?.broadcastEnded()
            }
        }
    }
    
    private func startRecording() {
        self.output?.startRecording()
    }
    
    private func stopRecording() {
        self.output?.stopRecording()
    }
}
