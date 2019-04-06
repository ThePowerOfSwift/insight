//
//  InsightWireframe.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


final class InsightWireframe {
 
    class func present(in viewController: UIViewController) {
        let insight = InsightViewControllerBuilder.build()
        viewController.present(insight, animated: true, completion: nil)
    }
}
