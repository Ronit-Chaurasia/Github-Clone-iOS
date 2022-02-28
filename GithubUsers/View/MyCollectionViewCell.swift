//
//  CollectionViewCell.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 10/02/22.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var repoCount: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    func setData(number: Int, text: String){
        repoCount.text = Utilities.roundOff(number)
        repoLabel.text = text
    }
}
