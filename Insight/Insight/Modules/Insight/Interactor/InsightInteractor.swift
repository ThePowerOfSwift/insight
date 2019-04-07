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
    
    init() {}
    
    func setupInteractor(with output: InsightInteractorOutputProtocol) {
        self.output = output
    }
}

extension InsightInteractor: InsightInteractorProtocol {
    func startOrStopRecording() {
        self.broadcastController.isBroadcasting ? stopBroadcast() : startBroadcast()
    }
    
    private func startBroadcast() {
        self.output?.startRecording()
    }
    
    private func stopBroadcast() {
        self.broadcastController.finishBroadcast { error in
            guard error == nil else { return }
            self.output?.recordEnded()
        }
    }
}
