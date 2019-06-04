//
//  InitialScreenPresenterBuilder.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct InitialScreenPresenterBuilder {
    
    static func build(delegate: InitialScreenPresenterDelegate) -> InitialScreenPresenter {
        let router = InitialScreenRouter()
        let presenter = InitialScreenPresenter(router: router)
        router.configureRouter(with: delegate)
        return presenter
    }
}
