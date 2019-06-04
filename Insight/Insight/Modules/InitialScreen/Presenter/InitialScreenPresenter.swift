//
//  InitialScreenPresenter.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct InitialScreenPresenter {
    
    var router: InitialScreenRouterProtocol?
    
    init(router: InitialScreenRouterProtocol) {
        self.router = router
    }
}

extension InitialScreenPresenter: InitialScreenPresenterProtocol {
   
    func didTapNewInsight() {
        self.router?.presentInsight()
    }
    
    func didTapTutorial() {
        self.router?.presentTutorial()
    }
}
