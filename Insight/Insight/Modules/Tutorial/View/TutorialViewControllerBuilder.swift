//
//  TutorialViewControllerBuilder.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct TutorialViewControllerBuilder {
    
    static func build() -> TutorialViewController {
        let viewController = TutorialViewController()
        let presenter = TutorialPresenterBuilder.build(with: viewController)
        viewController.setupViewController(with: presenter)
        return viewController
    }
}
