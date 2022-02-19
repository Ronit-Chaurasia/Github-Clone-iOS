//
//  ContributersTableViewCell.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 16/02/22.
//

import UIKit
import SDWebImage

class ContributorsTableViewCell: UITableViewCell {

    @IBOutlet weak var contributorName: UILabel!
    @IBOutlet weak var contributorImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(contributorsList: ContributorModal){
        contributorName.text = contributorsList.name
        contributorImg.sd_setImage(with: URL(string: contributorsList.avatar_url!))
        contributorImg.makeImageCircular()
    }
}
