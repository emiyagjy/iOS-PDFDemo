//
//  ViewController.swift
//  PDFDemo
//
//  Created by GujyHy on 2018/3/15.
//  Copyright © 2018年 Gujy. All rights reserved.
//

import UIKit

let AppName    = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as! String

let KEY_TITLE     = "title"
let KEY_CLASS     = "class"
let KEY_CLASSNAME = "classname"

class ViewController: UIViewController {
    
    var mainTableView:UITableView!
  
    var dataSource:[Any] = [
    {
        let cell  = [KEY_TITLE:"UIWebView & WKWebView",
                     KEY_CLASSNAME:"PDFWebViewController",
                     KEY_CLASS:PDFWebViewController()] as [String : Any]
        return cell
        }(),
    {
        let cell = [KEY_TITLE:"Core Graphic",
                    KEY_CLASSNAME:"PDFCoreGraphicViewController",
                    KEY_CLASS:PDFCoreGraphicViewController()] as [String : Any]
        
        return cell
        }(),
    {
        let cell = [KEY_TITLE:"PDFKit iOS 11",
                    KEY_CLASSNAME:"PDFKitViewController",
                    KEY_CLASS:PDFKitViewController()] as [String : Any]
        return cell
        }(),
    {
        let cell = [KEY_TITLE:"QLPreviewController",
                    KEY_CLASSNAME:"PDFQLPreviewController",
                    KEY_CLASS:PDFKitViewController()] as [String : Any]
        return cell
        }()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PDF"
        self.view.backgroundColor = UIColor.white
        self.initControls()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Public
    // MARK: - Private
    func initControls() {
        let tbFrame = self.view.bounds
//        tbFrame.size.height = /
//            UIScreen.main.bounds.size.height  - kNaviBarHeight
        self.mainTableView = UITableView(frame: tbFrame)
        self.mainTableView.showsHorizontalScrollIndicator = false
        self.mainTableView.showsVerticalScrollIndicator   = false
        self.mainTableView.backgroundColor                = .clear
        self.mainTableView.dataSource                     = self
        self.mainTableView.delegate                       = self
        self.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.view.addSubview(self.mainTableView)
    }
 
    
    // MARK: - Events
    
    @objc func testButtonAction(_ button:UIButton){
        
//        let vc = JYHomeDetailsViewController()
//        self.navigationController?.ex_pushViewController(vc, animated: true)
        
    }
    // MARK: - lazy
    
    // MARK: - Extension
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell?.accessoryType  = .disclosureIndicator
        cell?.selectionStyle = .none
        
        let index = indexPath.row
        let data  = self.dataSource[index] as! [String:Any]
        cell?.textLabel?.text = data[KEY_TITLE] as? String
        return cell!
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index     = indexPath.row
        let data      = self.dataSource[index] as! [String:Any]
        let classname = data[KEY_CLASSNAME] as! String
        let anyClass:AnyClass = NSClassFromString(AppName + "." + classname)!
        let myVC:UIViewController   = (anyClass as! UIViewController.Type).init()
        self.navigationController?.pushViewController(myVC, animated: true)
        
        //        tableView.deselectRow(at: <#T##IndexPath#>, animated: <#T##Bool#>)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

