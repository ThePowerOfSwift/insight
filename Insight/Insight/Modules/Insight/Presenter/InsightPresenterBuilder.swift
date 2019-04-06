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
        let interactor = InsightInteractorBuilder.build()
        let presenter = InsightPresenter(interactor: interactor, output: output)
        interactor.setupInteractor(with: presenter)
        
        return presenter
    }
}
