//
//  InitialScreenViewControllerBuilder.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct InitialScreenViewControllerBuilder {
    
    static func build() -> InitialScreenViewController {
        let presenter = InitialScreenPresenterBuilder.build()
        let viewController = InitialScreenViewController()
        viewController.setupViewController(with: presenter)
    
        return viewController
    }
}
