//
//  InsightPresenter.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import ReplayKit


final class InsightPresenter {
    
    private var interactor: InsightInteractorProtocol?
    private weak var output: InsightPresenterOutputProtocol?
    
    private let controller = RPBroadcastController()
    
    init(interactor: InsightInteractorProtocol, output: InsightPresenterOutputProtocol) {
        self.interactor = interactor
        self.output = output
    }
}

extension InsightPresenter: InsightPresenterProtocol {
  
    func didTapCameraButton() {
        
    }
    
    func didTapRecordButton() {
        self.interactor?.startOrStopRecording()
    }
}

extension InsightPresenter: InsightInteractorOutputProtocol {
    
    func startRecording() {
        self.output?.startRecording()
    }
    
    func recordEnded() {
        self.output?.recordEnded()
    }
}
