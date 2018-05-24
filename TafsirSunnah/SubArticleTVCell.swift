//
//  SubArticleTVCell.swift
//  TafsirSunnah
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/01/2018.
//  Copyright © 2018 MZMZ. All rights reserved.
//

import UIKit

class SubArticleTVCell: UITableViewCell {
    
    @IBOutlet weak var uilSATVCSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(data: String) {
        
        uilSATVCSubTitle.text = data
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
