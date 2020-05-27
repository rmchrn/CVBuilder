//
//  PDFConvertible.swift
//  CVBuilder
//
//  Created by Ramcharan Reddy Gaddam on 27/05/20.
//  Copyright © 2020 Ramcharan Reddy Gaddam. All rights reserved.
//

import UIKit

protocol PDFConverible: AnyObject {
    func createPDF(from view: UIView, withName name: String)
}

extension PDFConverible where Self: UIScrollView {
    func createPDF(from view: UIView, withName name: String) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputFileURL = documentDirectory.appendingPathComponent("\(name).pdf")
        debugPrint("URL:", outputFileURL)
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: view.frame.origin, size: contentSize))
        do {
            try pdfRenderer.writePDF(to: outputFileURL, withActions: { context in
                context.beginPage()
                view.layer.render(in: context.cgContext)
            })
        } catch {
            print("Could not create PDF file: \(error)")
        }
    }
}
