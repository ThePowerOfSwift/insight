//
//  InitialScreenRouter.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


class InitialScreenRouter: InitialScreenRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func configureRouter(with viewController: InitialScreenPresenterDelegate) {
        self.viewController = viewController as? UIViewController
    }
   
    func presentInsight() {
        guard let viewController = self.viewController else { return }
        let insightViewController = InsightViewControllerBuilder.build()
        viewController.present(insightViewController, animated: false, completion: nil)
    }
    
    func presentTutorial() {
        guard let viewController = self.viewController else { return }
        let tutorialViewController = TutorialViewControllerBuilder.build()
        viewController.present(tutorialViewController, animated: false, completion: nil)
    }
}
