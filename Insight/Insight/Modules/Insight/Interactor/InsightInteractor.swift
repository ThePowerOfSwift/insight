//
//  InsightInteractor.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


final class InsightInteractor {
    
    private weak var output: InsightInteractorOutputProtocol?
    
    init() {

    }
    
    func setupInteractor(with output: InsightInteractorOutputProtocol) {
        
    }
}

extension InsightInteractor: InsightInteractorProtocol {
    
}
