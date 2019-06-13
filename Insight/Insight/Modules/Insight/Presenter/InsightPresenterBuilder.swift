//
//  InsightPresenterBuilder.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct InsightPresenterBuilder {
    
    static func build(delegate: InsightPresenterDelegate) -> InsightPresenter {
        let recordInteractor = InsightRecorderInteractorBuilder.build()
        let documentInteractor = InsightDocumentInteractorBuilder.build()
        let presenter = InsightPresenter(recordInteractor: recordInteractor, documentInteractor: documentInteractor, delegate: delegate)
        recordInteractor.setupInteractor(with: presenter)
        documentInteractor.setupInteractor(with: presenter)
        
        return presenter
    }
}
