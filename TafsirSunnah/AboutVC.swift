//
//  AboutVC.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 10/03/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var uiivAVCBackToMain: UIImageView!
    @IBOutlet weak var uilAVCWriterTalk: UILabel!
    @IBOutlet weak var uilAVCProducerTalk: UILabel!
    @IBOutlet weak var uilAVCEmailToUs: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let backToMainGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(backToMain))
        backToMainGestureRecognizer.numberOfTapsRequired = 1
        uiivAVCBackToMain.addGestureRecognizer(backToMainGestureRecognizer)
        uiivAVCBackToMain.isUserInteractionEnabled = true
        
        let writerTalkGR: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(writerTalk))
        writerTalkGR.numberOfTapsRequired = 1
        uilAVCWriterTalk.addGestureRecognizer(writerTalkGR)
        uilAVCWriterTalk.isUserInteractionEnabled = true
        
        let producerTalkGR: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(producerTalk))
        producerTalkGR.numberOfTapsRequired = 1
        uilAVCProducerTalk.addGestureRecognizer(producerTalkGR)
        uilAVCProducerTalk.isUserInteractionEnabled = true
        
        let emailToUs: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(emailToUsGR))
        emailToUs.numberOfTapsRequired = 1
        uilAVCEmailToUs.addGestureRecognizer(emailToUs)
        uilAVCEmailToUs.isUserInteractionEnabled = true
    }

    @objc func backToMain(sender: UITapGestureRecognizer) {
        print("dismissing")
        self.dismiss(animated: true, completion: {})
    }
    
    @objc func writerTalk(sender: UITapGestureRecognizer) {
        let wtvc = WriterTalkViewController()
        self.present(wtvc, animated: true, completion: nil)
    }
    
    @objc func producerTalk(sender: UITapGestureRecognizer) {
        let ptvc = ProducerTalkViewController()
        self.present(ptvc, animated: true, completion: nil)
    }
    
    @objc func emailToUsGR(sender: UITapGestureRecognizer) {
        let emailUrl: URL = URL.init(string: "mailto:shahadikberadik.hilmi@outlook.com")!
        UIApplication.shared.open(emailUrl, options: [:], completionHandler: nil)
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
