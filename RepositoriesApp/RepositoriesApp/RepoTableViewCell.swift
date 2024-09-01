//
//  RepoTableViewCell.swift
//  RepositoriesApp
//
//  Created by Mariam Abdelhamid on 9/1/24.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleTxt: UILabel!
    @IBOutlet private weak var descTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCell(item: Item) {
        titleTxt.text = item.name
        descTxt.text = item.description
    }
}
