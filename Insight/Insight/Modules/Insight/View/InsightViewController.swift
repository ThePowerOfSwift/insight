//
//  InsightViewController.swift
//  Insight
//
//  Created by Douglas Mandarino on 06/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import UIKit


class InsightViewController: UIViewController {
    
    private var presenter: InsightPresenterProtocol?
    
    @IBOutlet weak var recordBarView: RecordBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupViewController(with presenter: InsightPresenterProtocol) {
        self.presenter = presenter
    }
}

extension InsightViewController: InsightPresenterOutputProtocol {
    
}
