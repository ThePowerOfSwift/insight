//
//  InsightPresenterBuilder.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct InsightPresenterBuilder {
    
    static func build(output: InsightPresenterOutputProtocol) -> InsightPresenter {
        let recordInteractor = InsightInteractorBuilder.build()
        let documentInteractor = InsightDocumentInteractorBuilder.build()
        let presenter = InsightPresenter(recordInteractor: recordInteractor, documentInteractor: documentInteractor, delegate: output)
        recordInteractor.setupInteractor(with: presenter)
        documentInteractor.setupInteractor(with: presenter)
        
        return presenter
    }
}
