//
//  DataAcquiring.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/01/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import Foundation
import UIKit

class DataAcquiring: NSObject {
    
    private struct DataAcquiringFileNames {
        static let MainMenu: String = "MainMenu.plist"
    }
    
    enum DataAcquiringFileName {
        case MainMenu
    }
    
    enum DataToRetrieve {
        case ArticleMenuLists
    }
    
    override init() {
        super.init()
    }
    
    func getPlistPath(fileName: DataAcquiringFileName) -> String {
        
        var plistFileName: String = ""
        
        if fileName == .MainMenu { plistFileName = DataAcquiringFileNames.MainMenu }
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docPath = paths[0] as String
        let plistPath = docPath.appending(plistFileName)
        
        return plistPath
    }
    
    func getBundlePath(fileName: DataAcquiringFileName) -> String {
        
        if(fileName == DataAcquiringFileName.MainMenu) {
            
            let bundlePath: URL = Bundle.main.url(forResource: "MainMenu", withExtension: "plist")!
            return bundlePath.path
        }
        else {
            return ""
        }
    }
    
    func displayData(data: DataToRetrieve) -> NSArray {
        
        //let plistPath: String = self.getPlistPath(fileName: DataAcquiringFileName.MainMenu)
        let bundlePath: String = self.getBundlePath(fileName: DataAcquiringFileName.MainMenu)
        
        let bundledOfContents: NSMutableArray = []
        var bundledSort: NSArray = []
        
        if FileManager.default.fileExists(atPath: bundlePath) {
            
            if let dataGot = NSMutableDictionary.init(contentsOfFile: bundlePath) {
                
                for (_, element) in dataGot.enumerated() {
                    bundledOfContents.add(["contentId":element.key,"contentData":element.value])
                }
                
                let sorted: NSSortDescriptor = NSSortDescriptor.init(key: "contentId", ascending: true)
                bundledSort = bundledOfContents.sortedArray(using: [sorted]) as NSArray
                
                return bundledSort
            
            }
            else {
                print("Data is not available!")
                return []
            }
        }
        else {
            print("File not exist!")
            return []
        }
        
    }
    
}
