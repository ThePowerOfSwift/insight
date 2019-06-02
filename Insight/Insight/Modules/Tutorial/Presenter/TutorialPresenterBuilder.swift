//
//  TutorialPresenterBuilder.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct TutorialPresenterBuilder {
    
    static func build(with delegate: TutorialPresenterDelegate) -> TutorialPresenter {
        let wireframe = TutorialWireframe()
        let presenter = TutorialPresenter(wireframe: wireframe, delegate: delegate)
        return presenter
    }
}
