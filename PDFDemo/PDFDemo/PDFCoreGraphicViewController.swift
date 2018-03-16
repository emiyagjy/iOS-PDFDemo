//
//  PDFCoreGraphicViewController.swift
//  PDFDemo
//
//  Created by GujyHy on 2018/3/15.
//  Copyright © 2018年 Gujy. All rights reserved.
//

import UIKit

class PDFCoreGraphicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawView = PDFDrawView(frame: self.view.bounds)
        
        self.view.addSubview(drawView)
        
 
    }

 

}
