//
//  DetailsVC.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 30/01/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import UIKit
import WebKit

class DetailsVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var uivDVCDetailContents: UIView!
    @IBOutlet weak var uilDVCTitleContent: UILabel!
    @IBOutlet weak var uibDVCBackBtn: UIButton!
    @IBOutlet weak var uibDVCNoteBtn: UIButton!
    @IBOutlet weak var uibDVCBookmarkBtn: UIButton!
    @IBOutlet weak var uibDVCShareBtn: UIButton!
    var webView: WKWebView?
    var contentDetails: NSDictionary = [:]
    var contentId: String = ""
    var parentContentId: String = ""
    var contentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("Contents: \(contentDetails)")
        
        checkBookmark();
        
        let webConf = WKWebViewConfiguration()
        webView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.uivDVCDetailContents.bounds.size.width, height: self.uivDVCDetailContents.bounds.size.height), configuration: webConf)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        webView?.isOpaque = false
        webView?.backgroundColor = UIColor.clear
        //webView?.scrollView.backgroundColor = UIColor.green
        
        if(webView != nil){
            
            self.uivDVCDetailContents.addSubview(webView!)
            webView!.uiDelegate = self
        
            webView!.loadHTMLString(contentDetails.value(forKey: "Content") as! String, baseURL: nil)
            
            webView!.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue))
            
            
        
            //self.webView!.translatesAutoresizingMaskIntoConstraints = false
            
            //let margins = uivDVCDetailContents.layoutMarginsGuide
            //self.webView!.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            //self.webView!.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            
            //NSLayoutConstraint.init(item: webView!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.uivDVCDetailContents, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0).isActive = true
            //NSLayoutConstraint.init(item: webView!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.uivDVCDetailContents, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0).isActive = true
            //NSLayoutConstraint.init(item: webView!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.uivDVCDetailContents.frame.size.width).isActive = true
            //NSLayoutConstraint.init(item: webView!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.uivDVCDetailContents.frame.size.height).isActive = true
            
            //print("First \((uivDVCDetailContents.constraints.filter({ $0.firstAttribute == .centerX }).first!).constant), margins \(margins)")
            
            
            
        } else {
            print("wkwebview failed to init")
        }
        
        //uitvDVCDetailContents.text = contentDetails.value(forKey: "Content") as! String
        //uitvDVCDetailContents.textAlignment = NSTextAlignment.natural
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.uibDVCBackBtn.addTarget(self, action: #selector(backVC), for: UIControlEvents.touchUpInside)
        self.uibDVCShareBtn.addTarget(self, action: #selector(openShare), for: UIControlEvents.touchUpInside)
        self.uibDVCNoteBtn.addTarget(self, action: #selector(openNote), for: UIControlEvents.touchUpInside)
        self.uibDVCBookmarkBtn.addTarget(self, action: #selector(setBookmark), for: UIControlEvents.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backVC() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openShare() {
        //let items:
        let whatsappShareURL: URL = URL.init(string: "whatsapp://send?text=try")!
        if(UIApplication.shared.canOpenURL(whatsappShareURL)) {
            
        }
        let activityVController: UIActivityViewController = UIActivityViewController.init(activityItems: [whatsappShareURL], applicationActivities: nil)
        activityVController.excludedActivityTypes = [UIActivityType.airDrop]
        self.present(activityVController, animated: true, completion: {})
    }
    
    @objc func openNote() {
        let notes = DisplayNotesViewController()
        self.present(notes, animated: true, completion: nil)
    }
    
    func checkBookmark() {
        let bookmarkArrays: NSMutableArray = (UserDefaults.standard.object(forKey: "BookMarks") as? NSMutableArray ?? []).mutableCopy() as! NSMutableArray
        
        if(bookmarkArrays.count != 0){
            print("data available")
            for i in 0...bookmarkArrays.count - 1 {
                print("get index")
                let getContents = bookmarkArrays.object(at: i) as! NSDictionary
                let getContentId = getContents.value(forKey: "CONTENT_ID") as! NSMutableArray
                let index = getContentId.index(of: contentId)
                if(index != NSNotFound) {
                    self.uibDVCBookmarkBtn.setImage(#imageLiteral(resourceName: "ic_bookmarked.png"), for: UIControlState.normal)
                }
                else {
                    self.uibDVCBookmarkBtn.setImage(#imageLiteral(resourceName: "ic_bookmark.png"), for: UIControlState.normal)
                }
                print("content id is \(getContentId), and index is \(index)")
            }
        }
        /*
        if (bookmarkArrays.index(of: contentId)) != NSNotFound {
           self.uibDVCBookmarkBtn.setImage(#imageLiteral(resourceName: "ic_bookmarked.png"), for: UIControlState.normal)
        }
        else {
             self.uibDVCBookmarkBtn.setImage(#imageLiteral(resourceName: "ic_bookmark.png"), for: UIControlState.normal)
        }
         */
    }
    
    @objc func setBookmark() {
        
        let bookmarkArrays: NSMutableArray = (UserDefaults.standard.object(forKey: "BookMarks") as? NSMutableArray ?? []).mutableCopy() as! NSMutableArray
        var getContents: NSDictionary = [:]
        var getContentId: NSMutableArray = []
        var index: Int = NSNotFound

        if(bookmarkArrays.count != 0){
            print("data available")
            for i in 0...bookmarkArrays.count - 1 {
                print("get index")
                getContents = bookmarkArrays.object(at: i) as! NSDictionary
                getContentId = (getContents.value(forKey: "CONTENT_ID") as! NSMutableArray).mutableCopy() as! NSMutableArray
                index = getContentId.index(of: contentId)
                if(index != NSNotFound) {
                    contentIndex = i
                }
                print("content id is \(getContentId), and index is \(index)")
            }
        }
        
        if (index != NSNotFound) {
            
            getContentId.removeObject(at: index)
            let redeclare: NSDictionary = ["PARENT_ID":parentContentId,"CONTENT_ID":getContentId]
            bookmarkArrays.replaceObject(at: contentIndex, with: redeclare)
            UserDefaults.standard.removeObject(forKey: "BookMarks")
            UserDefaults.standard.set(
                bookmarkArrays,
                forKey: "BookMarks"
            )
            UserDefaults.standard.synchronize()
            self.uibDVCBookmarkBtn.setImage(#imageLiteral(resourceName: "ic_bookmark.png"), for: UIControlState.normal)
            print("Bookmark set (Remove) \(UserDefaults.standard.object(forKey: "BookMarks"))");
            
        }
        else {
            self.uibDVCBookmarkBtn.setImage(#imageLiteral(resourceName: "ic_bookmarked.png"), for: UIControlState.normal)
            
            bookmarkArrays.add(["PARENT_ID":parentContentId,"CONTENT_ID":[contentId]])
            UserDefaults.standard.set(
                bookmarkArrays,
                forKey: "BookMarks"
            )
            print("Bookmark set (add) \(String(describing: UserDefaults.standard.object(forKey: "BookMarks")))");
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("nav finished")
        
        let getFont: NSDictionary = UserDefaults.standard.object(forKey: "FontSizes") as! NSDictionary
        webView.evaluateJavaScript(String.init(format: "var style = document.createElement('style'); style.innerHTML = '#starter { font-size:50px; font-family:Arial; } #starter .tajukArtikel { font-size: %@; text-align:justify; text-justify:inter-word; } #starter .ayatArtikel { font-size: %@; text-align:justify; text-justify:inter-word; } #starter .ayatQuran { font-size: %@; font-family:Arial; line-height:1.6 }'; document.head.appendChild(style)", getFont.value(forKey: "Title") as! String,getFont.value(forKey: "Articles") as! String,getFont.value(forKey: "Quran") as! String), completionHandler: { (response,error) in
            print("Inject jscript status: \(response)")
            print("Inject jscript error: \(error)")
        } )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
