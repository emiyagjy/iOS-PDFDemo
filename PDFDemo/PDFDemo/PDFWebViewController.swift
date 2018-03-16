//
//  PDFWebViewController.swift
//  PDFDemo
//
//  Created by GujyHy on 2018/3/15.
//  Copyright © 2018年 Gujy. All rights reserved.
//

import UIKit
import WebKit

class PDFWebViewController: UIViewController {

    var path:String? {
        get {
            return Bundle.main.path(forResource: "Sample", ofType: "pdf")
        }
    }
    var wkWebViewPathURL:URL? {
        get {
            let fm       = FileManager.default
            let documenPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first!
            if let _path = self.path {
                let pathUrl = URL(fileURLWithPath: _path)
                let toPath = documenPath.appending("/\(pathUrl.lastPathComponent)")
                try! fm.copyItem(atPath: _path, toPath: toPath)
                return URL(fileURLWithPath: toPath)
            }
            return nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // UIWebView
        let webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        if let path = self.path {
             let request = URLRequest(url: URL(string: path)!)
              webView.loadRequest(request)
        }
        
        // WKWebView
        let wkView = WKWebView(frame: self.view.bounds)
        self.view.addSubview(wkView)
        if let url = self.wkWebViewPathURL {
            wkView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
    
   
    
    
}
