//
//  PDFPageViewModel.swift
//  Insight
//
//  Created by Douglas Mandarino on 24/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


struct PDFPageViewModel {
    
    var image: UIImage
}

struct PDFPageViewModelMapper {
    
    static func make(from document: PDFDocument) -> [PDFPageViewModel] {
        var viewModels = [PDFPageViewModel]()
        let images = document.pages?.compactMap({ $0.page })
        images?.forEach({ viewModels.append(PDFPageViewModel(image: $0)) })
        return viewModels
    }
}
