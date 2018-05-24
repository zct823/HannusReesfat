//
//  BookmarkListVC.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 14/04/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import UIKit

class BookmarkListVC: UIViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var uilBLVCTitle: UILabel!
    @IBOutlet weak var uitvBLVCSubList: UITableView!
    
    var bookmarkLists: [String]? = nil
    
    var contentDict: NSDictionary = [:]
    var sortedContentIds: NSArray = []
    var sortedDataContent: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uitvBLVCSubList.delegate = self
        self.uitvBLVCSubList.dataSource = self

        // Do any additional setup after loading the view.
        
        bookmarkLists = UserDefaults.standard.object(forKey: "BookMarks") as? [String]
        
    }
    
    func performSampleData() {
        
        let getData: DataAcquiring = DataAcquiring.init()
        var contentArray = getData.displayData(data: .ArticleMenuLists)
        
        let getKeys = contentDict.value(forKey: "contentId") as! String
        let getDataContent = contentDict.value(forKey: "contentData") as? NSDictionary ?? [:]
        let getDataSubContent = getDataContent.value(forKey: "SubContent") as? NSDictionary ?? [:]
        let getDataSubContentKeys = (getDataSubContent.allKeys as! [String]).sorted(by: <)
        
        sortedContentIds = NSArray.init(array: getDataSubContentKeys)
        print("subcontentkey srot \(sortedContentIds)")
        
        for i in 0...getDataSubContent.count - 1 {
            
            sortedDataContent.add(getDataSubContent.value(forKey: getDataSubContentKeys[i]) as! NSDictionary)
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.contentArray.count
        return bookmarkLists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BookmarkListTVCell = tableView.dequeueReusableCell(withIdentifier: "BookmarkListCellID") as! BookmarkListTVCell
        //let getThingState = sortedDataContent.object(at: indexPath.row) as! NSDictionary
        //cell.updateCell(data: getThingState.value(forKey: "Title") as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //self.selectedContent = indexPath.row
        //self.performSegue(withIdentifier: "TS_GOTO_CONTENT", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
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

class BookmarkListTVCell: UITableViewCell {
    
    @IBOutlet weak var uilBLTVCSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(data: String) {
        
        uilBLTVCSubTitle.text = data
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
