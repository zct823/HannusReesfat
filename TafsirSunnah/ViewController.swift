//
//  ViewController.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 24/01/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var uibMVCStartBtn: UIButton!
    @IBOutlet weak var uibMVCAboutUs: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        uibMVCStartBtn.addTarget(self, action: #selector(goToListArticle), for: UIControlEvents.touchUpInside)
        uibMVCAboutUs.addTarget(self, action: #selector(gotoAboutUs), for: UIControlEvents.touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
    }
    
    @objc func goToListArticle() {
        
        self.performSegue(withIdentifier: "TS_GOTO_LIST", sender: self)
        
    }
    
    @objc func gotoAboutUs() {
        self.performSegue(withIdentifier: "TS_GOTO_ABOUTUS", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

