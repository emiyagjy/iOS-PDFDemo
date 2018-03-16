//
//  PDFDrawView.swift
//  PDFDemo
//
//  Created by GujyHy on 2018/3/15.
//  Copyright © 2018年 Gujy. All rights reserved.
//

import UIKit

class PDFDrawView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
       
        let context:CGContext  = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.white.cgColor)
        context.fill(self.bounds)
        let url = Bundle.main.url(forResource: "Sample", withExtension: "pdf")!
        let cUrl      = url as CFURL
        let pdfDoucment:CGPDFDocument = CGPDFDocument(cUrl)!
        let page:CGPDFPage = pdfDoucment.page(at: 1)! //  第一页
        
//        let pageRect       = page.getBoxRect(CGPDFBox.mediaBox)
//        let scale: CGFloat = min(self.bounds.size.width / pageRect.size.width , self.bounds.size.height / pageRect.size.height)
        
        context.translateBy(x: 0, y: self.bounds.size.height) // 垂直下移 height 高度
        context.scaleBy(x: 1, y: -1) // 再垂直向上翻转
//        context.scaleBy(x: scale, y: scale)
        
        // 创建一个仿射变换，该变换基于将PDF页的BOX映射到指定的矩形中
        let transform:CGAffineTransform =  page.getDrawingTransform(CGPDFBox.cropBox, rect: self.bounds, rotate: 0, preserveAspectRatio: true)
        // (media, crop, bleed, trim, art)与指定的PDF页 ,相交的部分 即为有效的矩形(effective rectangle)
        //  rotate 非零且是90的倍数 ，正值往右旋转；负值往左旋转，传入的是角度，而不是弧度
        // preserveAspectRatio = true 保持长宽比
        
        context.concatenate(transform)
        context.saveGState()
        context.drawPDFPage(page)
        context.restoreGState()
        
    }

}
