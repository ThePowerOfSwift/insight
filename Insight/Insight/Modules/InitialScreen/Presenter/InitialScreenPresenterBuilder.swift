//
//  InitialScreenPresenterBuilder.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct InitialScreenPresenterBuilder {
    
    static func build() -> InitialScreenPresenter {
        let wireframe = InitialScreenWireframe()
        let presenter = InitialScreenPresenter(wireframe: wireframe)
        return presenter
    }
}
