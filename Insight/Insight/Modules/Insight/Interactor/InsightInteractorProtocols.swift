//
//  InsightInteractorProtocols.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


protocol InsightInteractorProtocol {
    func startOrStopRecording()
    func startOrStopBroadcast()
    func fetchPresentation(url: URL)
}

protocol InsightInteractorOutputProtocol: class {
    func startRecording()
    func stopRecording()
    func startBroadcast()
    func broadcastEnded()
    func didFetchDocument(document: PDFDocument)
    func didFailFetchingDocument()
}
