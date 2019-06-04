//
//  TutorialRouter.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


class TutorialRouter: TutorialRouterProtocol {
    
    weak var viewController: UIViewController?
    
    func configureRouter(with viewController: TutorialPresenterDelegate) {
        self.viewController = viewController as? UIViewController
    }
   
    func presentInsight() {
        guard let viewController = self.viewController else { return }
        let insightViewController = InsightViewControllerBuilder.build()
        viewController.present(insightViewController, animated: false, completion: nil)
    }
}
