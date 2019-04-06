//
//  InsightPresenter.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


final class InsightPresenter {
    
    private var interactor: InsightInteractorProtocol?
    private weak var output: InsightPresenterOutputProtocol?
    
    init(interactor: InsightInteractorProtocol, output: InsightPresenterOutputProtocol) {
        self.interactor = interactor
        self.output = output
    }
}

extension InsightPresenter: InsightPresenterProtocol {
    
}

extension InsightPresenter: InsightInteractorOutputProtocol {
    
}
