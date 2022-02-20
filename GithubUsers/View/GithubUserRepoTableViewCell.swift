//
//  TableViewCell.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 12/02/22.
//

import UIKit
import TagListView

class TableViewCell: UITableViewCell, TagListViewDelegate {

    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectDesc: UILabel!
    @IBOutlet weak var langColor: UIImageView!
    @IBOutlet weak var projectImg: UIImageView!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var tagViewHeightConstaint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tagView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(repoList: RepoModal){
        projectImg.makeImageCircular()
        projectName.text = repoList.name
        projectDesc.text = repoList.description
        language.text = repoList.language
        starsCount.text = Utilities.roundOff(number: repoList.stargazers_count ?? 0)
        forksCount.text = Utilities.roundOff(number: repoList.forks ?? 0)
        lastUpdate.text = Utilities.dateDifference(repoDate: repoList.updated_at ?? "")
        
        if repoList.topics?.count == 0{
            self.tagViewHeightConstaint.constant = 1
        }
        else{
            self.tagView.removeAllTags()
            self.tagView.addTags(repoList.topics ?? [])
        }

        if(repoList.language == nil){
           langColor.isHidden = true
        }
        else {langColor.isHidden = false}
    }
}

