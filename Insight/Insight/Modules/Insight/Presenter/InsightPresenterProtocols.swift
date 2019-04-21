//
//  InsightPresenterProtocols.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


protocol InsightPresenterProtocol {
    init(interactor: InsightInteractorProtocol, output: InsightPresenterOutputProtocol)
    func didTapRecordButton(toBroadcast: Bool)
    func didSelectImport()
}

protocol InsightPresenterOutputProtocol: class {
    func startBroadcast()
    func broadcastEnded()
    func startRecording()
    func stopRecording()
}
