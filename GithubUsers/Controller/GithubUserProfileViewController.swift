//
//  ViewController.swift
//  GithubUsers
//
//  Created by Ronit Chaurasia on 06/02/22.
//

import UIKit
import TagListView

class ViewController: UIViewController, GitUserProfileDelegate {
    
    // MARK: Stored Properties
    let userViewModal = GitUserProfileViewModal(repository: FetchUserRepository())
    var user = "kudoleh"
    let margin: CGFloat = 10
    
    // MARK: Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var userUserName: UILabel!
    @IBOutlet weak var follow: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var collectionViewHeightConstraints: NSLayoutConstraint!
    
    // MARK: Actions
    @IBAction func changingSegmentValue(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(userViewModal.userPropertiesData.isEmpty){
            collectionViewHeightConstraints.constant = 0
        }
        
        // MARK: Making the height of tableViewCell automatic
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        
        // MARK: Assigning delegate and data sources
        tableView.dataSource = self
        tableView.delegate = self
        userViewModal.delegate = self

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.isScrollEnabled = false //disabling scrolling of collection view
        
        // MARK: Hitting the API
        userViewModal.fetchUserData(user: self.user)
        userViewModal.fetchUserRepoData(user: self.user)
        
        myCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        guard let collectionView = myCollectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        userImg.makeImageCircular() // Makes imageView circular
        follow.layer.cornerRadius = 22
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: Conforming UserFetchApiDelegate Protocol
    func updateUIAfterFetchUserData(){
        DispatchQueue.main.async {
            guard let userName = self.userViewModal.userData?.userName else{return}
            self.userName.text = self.userViewModal.userData?.name
            self.userUserName.text = String("@") + (userName)
            self.userBio.text = self.userViewModal.userData?.bio
            guard let imgData = self.userViewModal.userData?.imgData else{return}
            self.userImg.image = UIImage(data: imgData)
            if(!self.userViewModal.userPropertiesData.isEmpty){
                self.collectionViewHeightConstraints.constant = 66
                self.myCollectionView.reloadData()
            }
        }
    }
    
    // MARK: Conforming RepoFetchApiDelegate Protocol
    func updateRepoAfterFetchUserData(){
        DispatchQueue.main.async {
            if(!self.userViewModal.repoList.isEmpty){
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: Extension for collectionView delegate & datasource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userViewModal.userPropertiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! MyCollectionViewCell
        let number = userViewModal.userPropertiesData[indexPath.row]
        let text = userViewModal.userProperties[indexPath.row]
        cell.setData(number: number, text: text)
        return cell
    }
}

// MARK: CollectionView Spacing
extension ViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = userViewModal.userProperties.count   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}

// MARK: Extention for TableView Delegate & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userViewModal.repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
        let repoList = userViewModal.repoList[indexPath.row]
        cell.setData(repoList: repoList)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contributorsVC = storyboard?.instantiateViewController(withIdentifier: "ContributorsViewController") as! ContributorsViewController
        contributorsVC.repoName = userViewModal.repoList[indexPath.row].name!
        contributorsVC.userName = self.user
        navigationController?.pushViewController(contributorsVC, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
