//
//  SubArticleListVC.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/01/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import UIKit

class SubArticleListVC: UIViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var searchController: UISearchController!
    var sortedDataContent: NSMutableArray = []
    var selectedContent: Int = 0
    var sortedContentIds: NSArray = []
    var selectedParentContentIds: String = ""
    @IBOutlet weak var uilSALVCTitle: UILabel!
    @IBOutlet weak var uitvSALVCSubList: UITableView!
    
    var contentDict: NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.uitvSALVCSubList.rowHeight = UITableViewAutomaticDimension
        self.uitvSALVCSubList.estimatedRowHeight = 80.0
        
        self.view.backgroundColor = Colors.backColor
        self.uitvSALVCSubList.backgroundColor = Colors.backColor
        
        self.uitvSALVCSubList.delegate = self
        self.uitvSALVCSubList.dataSource = self
        
        self.searchController = UISearchController.init(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        
        let menuBtnImg: UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "ic_listmenu.png"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(openDrawerMenu))
        
        //self.navigationItem.leftBarButtonItem = menuBtnImg
        self.performSampleData()
        
    }
    
    func performSampleData() {
        
        let getKeys = contentDict.value(forKey: "contentId") as! String
        let getDataContent = contentDict.value(forKey: "contentData") as? NSDictionary ?? [:]
        let getDataSubContent = getDataContent.value(forKey: "SubContent") as? NSDictionary ?? [:]
        let getDataSubContentKeys = (getDataSubContent.allKeys as! [String]).sorted(by: <)
        
        sortedContentIds = NSArray.init(array: getDataSubContentKeys)
        selectedParentContentIds = getKeys
        //sortedParentContentIds = NSArray.init(array: getKeys)
        print("subcontentkey srot \(sortedContentIds)")
        
        for i in 0...getDataSubContent.count - 1 {
            
            sortedDataContent.add(getDataSubContent.value(forKey: getDataSubContentKeys[i]) as! NSDictionary)
        }
        
        //self.contentArray = ["Ringkasan 20 Usul Tafsir Al-Quran","Usul 1: Tafsir Quran dengan Quran", "Usul 2: Tafsir Quran dan Hadist", "Usul 3: Tafsir Quran dengan Atsar Sahabat"]
        
        //self.uitvSALVCSubList.reloadData()
    }
    
    @objc func openDrawerMenu() {
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.contentArray.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SubArticleTVCell = tableView.dequeueReusableCell(withIdentifier: "SubArticleMenuCellID") as! SubArticleTVCell
        let getThingState = sortedDataContent.object(at: indexPath.row) as! NSDictionary
        cell.updateCell(data: getThingState.value(forKey: "Title") as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedContent = indexPath.row
        self.performSegue(withIdentifier: "TS_GOTO_CONTENT", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationVC: DetailsVC = segue.destination as! DetailsVC
        destinationVC.contentDetails = sortedDataContent.object(at: self.selectedContent) as! NSDictionary
        destinationVC.contentId = sortedContentIds.object(at: self.selectedContent) as! String
        destinationVC.parentContentId = selectedParentContentIds
    }
    

}
