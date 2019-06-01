//
//  InitialScreenWireframe.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


struct InitialScreenWireframe: InitialScreenWireframeProtocol {
   
    func presentInsight() {
        let insightViewController = InsightViewControllerBuilder.build()
        InsightWireframe.present(viewController: insightViewController)
    }
    
    func presentTutorial() {
        let tutorialViewController = TutorialViewController()
        InsightWireframe.present(viewController: tutorialViewController)
    }
}
