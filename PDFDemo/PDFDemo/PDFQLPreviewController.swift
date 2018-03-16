//
//  PDFQLPreviewController.swift
//  PDFDemo
//
//  Created by GujyHy on 2018/3/15.
//  Copyright © 2018年 Gujy. All rights reserved.
//

import UIKit
import QuickLook

class PDFQLPreviewController: QLPreviewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
    }
}

extension PDFQLPreviewController : QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return Bundle.main.url(forResource: "Sample", withExtension: "pdf")! as QLPreviewItem
    }
}
