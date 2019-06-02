//
//  InsightViewControllerBuilder.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct InsightViewControllerBuilder {
    
    static func build() -> InsightViewController {
        let viewController = InsightViewController()
        let presenter = InsightPresenterBuilder.build(delegate: viewController)
        viewController.setupViewController(with: presenter)
        
        return viewController
    }
}
