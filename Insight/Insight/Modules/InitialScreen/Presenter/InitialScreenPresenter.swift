//
//  InitialScreenPresenter.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation


struct InitialScreenPresenter {
    
    var wireframe: InitialScreenWireframeProtocol?
    
    init(wireframe: InitialScreenWireframeProtocol) {
        self.wireframe = wireframe
    }
}

extension InitialScreenPresenter: InitialScreenPresenterProtocol {
   
    func didTapNewInsight() {
        self.wireframe?.presentInsight()
    }
    
    func didTapTutorial() {
        self.wireframe?.presentTutorial()
    }
}
