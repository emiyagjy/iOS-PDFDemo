## 前言
	
最近一段时间一直在研究有关 iOS 实现浏览 PDF 的功能。我就简单说分享一下我在研究过程中的一些总结。
	
	
---
	
## 正文
	
iOS 实现 PDF 浏览我大致整理了一下有四种，而大多数的第三方库都是使用
第3种的方式 Core Graphic 对 PDF 进行绘制的。
	
* 1、用 UIWebView/WKWebView 进行展示。
* 2、用 QuickLook 框架中的 QLPreviewController 进行展示。
* 3、用 CoreGraphics 进行绘制。
* 4、iOS 11 新出的 PDFKit。
	
 
### 分析
	
#### 1、用 UIWebView/WKWebView 进行展示。
	
	
``` swift
let webView = UIWebView(frame: self.view.bounds)
self.view.addSubview(webView)
if let path = self.path {
  	let request = URLRequest(url: URL(string: path)!)
	webView.loadRequest(request)
}
```
```
let wkView = WKWebView(frame: self.view.bounds)
self.view.addSubview(wkView)
if let url = self.wkWebViewPathURL {
	wkView.loadFileURL(url, allowingReadAccessTo: url)
}

```
用 WKWebView 时一定要把 pdf 文件的绝对路径转成相对路径
	
#### 2、用 QuickLook 框架中的 QLPreviewController 进行展示。
	
	
``` swift
extension PDFQLPreviewController : QLPreviewControllerDataSource {
	func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
  		return 1
	}
	func previewController(_ controller: QLPreviewController, 	previewItemAt index: Int) -> QLPreviewItem {
  	 	return Bundle.main.url(forResource: "Sample", withExtension: 		"pdf")! as QLPreviewItem
	}
}
```
记得要导入 QuickLook
	
#### 3、用 Core Graphic 进行绘制
``` swift
let context:CGContext  = UIGraphicsGetCurrentContext()!
context.setFillColor(UIColor.white.cgColor)
context.fill(self.bounds)
let url  = Bundle.main.url(forResource: "Sample", withExtension: "pdf")!
let cUrl = url as CFURL
let pdfDoucment:CGPDFDocument = CGPDFDocument(cUrl)!
let page:CGPDFPage = pdfDoucment.page(at: 1)! //  第一页
context.translateBy(x: 0, y: self.bounds.size.height) // 垂直下移 height 高度
context.scaleBy(x: 1, y: -1) // 再垂直向上翻转
// 创建一个仿射变换，该变换基于将PDF页的BOX映射到指定的矩形中
let transform:CGAffineTransform =  page.getDrawingTransform(CGPDFBox.cropBox, rect: self.bounds, rotate: 0, preserveAspectRatio: true)
context.concatenate(transform)
context.saveGState()
context.drawPDFPage(page)
context.restoreGState()
	
```
#### 4、iOS 11 新出的 PDFKit
![mypic1]({{site.url}}/img/postsimgs/2018-03-08-pic1.png)

```
if let documentURL = Bundle.main.url(forResource: "Sample", withExtension: "pdf") {
    if let document = PDFDocument(url: documentURL) {
        pdfView.document = document
    }
}
```

	
	
## 总结
 
本次我主要把 iOS 端 主要的几种 PDF 显示方式给整理了一下。如果想要研发一款功能强大的 PDF App 的话，建议把 CoreGraphics 好好研究一下。
 
