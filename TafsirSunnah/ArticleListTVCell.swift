//
//  ArticleListTVCell.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/01/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import UIKit

class ArticleListTVCell: UITableViewCell {
    
    @IBOutlet weak var uilALTVCTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(data: String) {
        
        uilALTVCTitle.text = data
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
