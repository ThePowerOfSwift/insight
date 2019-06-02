//
//  TutorialWireframe.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


struct TutorialWireframe: TutorialWireframeProtocol {
   
    func presentInsight() {
        let insightViewController = InsightViewControllerBuilder.build()
        InsightWireframe.present(viewController: insightViewController)
    }
}
