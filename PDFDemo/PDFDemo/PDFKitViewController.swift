//
//  PDFKitViewController.swift
//  PDFDemo
//
//  Created by GujyHy on 2018/3/15.
//  Copyright © 2018年 Gujy. All rights reserved.
//

import UIKit
import PDFKit

class PDFKitViewController: UIViewController {
    
    var pdfDocument:PDFDocument?
    var pdfView:PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let doucmentUrl = Bundle.main.url(forResource: "Sample", withExtension: "pdf") {
            if let _document = PDFDocument(url: doucmentUrl) {
                self.pdfDocument = _document
            }
        }

        self.configurePdfView()
        self.view.backgroundColor = UIColor.blue;
        
    }
    
    // MARK: Private
    private func configurePdfView() {
        
        self.pdfView = PDFView(frame: self.view.bounds)
        self.view.addSubview(self.pdfView)
        
        pdfView.backgroundColor = UIColor.black
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        // singlePage 只显示一页
        pdfView.displayDirection = .horizontal
        pdfView.displaysPageBreaks = true
        //        pdfView.displaysPageBreaks
        // 如果调用 usePageViewController（true）方法会使 displayMode 失效
        pdfView.usePageViewController(true, withViewOptions:nil)
        // [UIPageViewControllerOptionSpineLocationKey: 20]
        
        let swipeRecog = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRecog.direction = .up
        
        //        let swipeRecog = UITapGestureRecognizer(target: self, action: #selector(handleSwipe))
        pdfView.addGestureRecognizer(swipeRecog)
        pdfView.delegate = self
        //        pdfView.addGestureRecognizer(pdfViewGestureRecognizer)
        
        pdfView.document = self.pdfDocument
        
        
        
    }
    @objc func handleSwipe(_ recognizer:UISwipeGestureRecognizer){
        if self.pdfView.canGoToNextPage() {
            self.pdfView.goToNextPage(nil)
        }
    }
    
    
    
}

extension PDFKitViewController: PDFViewDelegate {
    func pdfViewPerformGo(toPage sender: PDFView){
        
        print(sender)
    }
    
}

