//
//  PDFPageMapper.swift
//  Insight
//
//  Created by Douglas Mandarino on 24/04/19.
//  Copyright © 2019 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit


struct PDFPageMapper {
    
    static func make(page: CGPDFPage, pageNumber: Int) -> PDFPage {
        var pdfPage = PDFPage()
        pdfPage.page = make(page: page)
        pdfPage.pageNumber = pageNumber
        return pdfPage
    }
    
    private static func make(page: CGPDFPage) -> UIImage? {
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            ctx.cgContext.drawPDFPage(page)
        }
        return img
    }
}
