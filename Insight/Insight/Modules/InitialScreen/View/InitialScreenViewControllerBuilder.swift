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
        let viewController = InitialScreenViewController()
        let presenter = InitialScreenPresenterBuilder.build(delegate: viewController)
        viewController.setupViewController(with: presenter)
    
        return viewController
    }
}
