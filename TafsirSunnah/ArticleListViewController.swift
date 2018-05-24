//
//  ArticleListViewController.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 24/01/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var searchController: UISearchController!
    var selectadosGritosDeEsperanza: NSDictionary = [:]
    @IBOutlet weak var uilALVCMainTitle: UILabel!
    @IBOutlet weak var uitvALVCArticleList: UITableView!
    
    var contentArray: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.uitvALVCArticleList.rowHeight = UITableViewAutomaticDimension
        self.uitvALVCArticleList.estimatedRowHeight = 80.0
        
        self.view.backgroundColor = Colors.backColor
        self.uitvALVCArticleList.backgroundColor = Colors.backColor
        
        self.uitvALVCArticleList.delegate = self
        self.uitvALVCArticleList.dataSource = self
        AppDelegate.articleVController = self
        
        self.searchController = UISearchController.init(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        
        let menuBtnImg: UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "ic_listmenu.png"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(openDrawerMenu))
        
        self.navigationItem.leftBarButtonItem = menuBtnImg
        performSampleData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    @objc func openDrawerMenu() {
        let notes = LeftMenuViewController()
        self.present(notes, animated: true, completion: nil)
    }
    
    func performSampleData() {
        
        let getData: DataAcquiring = DataAcquiring.init()
        self.contentArray = getData.displayData(data: .ArticleMenuLists)
        
        print("contentArray \(self.contentArray)")
        
        //self.uitvALVCArticleList.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ArticleListTVCell = tableView.dequeueReusableCell(withIdentifier: "ArticleMenuCellID") as! ArticleListTVCell
        
        let gritosDeEsperanza: NSDictionary = self.contentArray.object(at: indexPath.row) as! NSDictionary
        let getKeys = gritosDeEsperanza.value(forKey: "contentId") as! String
        let getDataContent = gritosDeEsperanza.value(forKey: "contentData") as? NSDictionary ?? [:]
        let getDataSubContent = getDataContent.value(forKey: "SubContent") as? NSDictionary ?? [:]
        let getDataSubContentKeys: [Any] = getDataSubContent.allKeys
        
        cell.updateCell(data: getDataContent.value(forKey: "Title") as? String ?? "N/A")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectadosGritosDeEsperanza = self.contentArray.object(at: indexPath.row) as! NSDictionary
        
        self.performSegue(withIdentifier: "TS_GOTO_SUBARTICLE", sender: self)
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
        
        if(segue.identifier == "TS_GOTO_SUBARTICLE"){
            let destinationVC: SubArticleListVC = segue.destination as! SubArticleListVC
            destinationVC.contentDict = selectadosGritosDeEsperanza
        }
        
        
        
    }
    

}
