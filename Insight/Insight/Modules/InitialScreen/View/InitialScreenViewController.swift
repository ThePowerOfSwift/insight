//
//  InitialScreenViewController.swift
//  Insight
//
//  Created by Douglas Mandarino on 01/06/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit


final class InitialScreenViewController: UIViewController {
    
    private var presenter: InitialScreenPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupViewController(with presenter: InitialScreenPresenterProtocol) {
        self.presenter = presenter
    }

    @IBAction func newInsight(sender: AnyObject) {
        self.presenter?.didTapNewInsight()
    }
    
    @IBAction func showTutorial(sender: AnyObject) {
        self.presenter?.didTapTutorial()
    }
}
