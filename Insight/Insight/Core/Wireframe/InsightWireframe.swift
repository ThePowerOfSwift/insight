//
//  InsightWireframe.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


struct InsightWireframe {
 
    static func present(viewController: UIViewController) {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController!.present(viewController, animated: false, completion: nil)
    }
}
