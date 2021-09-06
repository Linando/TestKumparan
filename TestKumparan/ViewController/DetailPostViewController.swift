//
//  DetailPostViewController.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import UIKit
import Alamofire

class DetailPostViewController: UIViewController {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    @IBOutlet weak var userNameButton: UIBarButtonItem!
    @IBOutlet weak var commentTableView: UITableView!
    
    var userName: String = ""
    var userID: Int?
    var postTitle: String = ""
    var postBody: String = ""
    var postID: Int?
    
    var commentData: [CommentModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        userNameButton.title = userName
        postTitleLabel.text = postTitle
        postBodyLabel.text = postBody
        AF.request("https://jsonplaceholder.typicode.com/posts/\(postID!)/comments").responseData { [weak self] response in
            switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        self!.commentData = try JSONDecoder().decode([CommentModel].self, from: data)
                        self!.commentTableView.reloadData()
                    } catch let error {
                        print(error)
                    }
                }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func userNameButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToUserDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToUserDetailVC"{
            let vc = segue.destination as! UserDetailViewController
            vc.userID = userID
        }
    }
    
}

extension DetailPostViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commentData == nil{
            return 0
        }else{
            return commentData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = commentTableView.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentTableViewCell{
            cell.commentAuthorNameLabel.text = commentData![indexPath.row].name
            cell.commentBodyLabel.text = commentData![indexPath.row].body
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 16, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            if commentData == nil{
                label.text = "0 Komentar"
            }else{
                label.text = "\(commentData!.count) Komentar"
            }
            label.font = .boldSystemFont(ofSize: 20)
            
            headerView.addSubview(label)
            
            return headerView
        }
}
