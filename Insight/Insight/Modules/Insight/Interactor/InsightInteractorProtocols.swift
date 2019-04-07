//
//  InsightInteractorProtocols.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


protocol InsightInteractorProtocol {
    func startOrStopRecording()
}

protocol InsightInteractorOutputProtocol: class {
    func startRecording()
    func recordEnded()
}
