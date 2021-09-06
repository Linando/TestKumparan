//
//  ViewController.swift
//  TestKumparan
//
//  Created by Linando Saputra on 04/09/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    var postData: [PostModel]?
    var selectedUserName: String?
    var selectedUserID: Int?
    var selectedPostTitle: String?
    var selectedPostBody: String?
    var selectedPostID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        AF.request("https://jsonplaceholder.typicode.com/posts").responseData { [weak self] response in
            switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        self!.postData = try JSONDecoder().decode([PostModel].self, from: data)
                        self!.homeTableView.reloadData()
                    } catch let error {
                        print(error)
                    }
                }
        }
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if postData == nil{
            return 0
        }else{
            return postData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = homeTableView.dequeueReusableCell(withIdentifier: "ListPostCell") as? ListPostTableViewCell{
            cell.titleLabel.text = postData![indexPath.row].title
            cell.bodyLabel.text = postData![indexPath.row].body
            AF.request("https://jsonplaceholder.typicode.com/users/\(postData![indexPath.row].userID)").responseData { response in
                switch response.result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        do {
                            let userData = try JSONDecoder().decode(UserModel.self, from: data)
                            cell.userNameLabel.text = "\(userData.name), \(userData.company.name)"
                        } catch let error {
                            print(error)
                        }
                    }
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! ListPostTableViewCell
        let newUsername = String(selectedCell.userNameLabel.text!.reversed())
        
        if let range = newUsername.range(of: ",") {
            let userName = newUsername[range.upperBound...].trimmingCharacters(in: .whitespaces)
            selectedUserName = String(userName.reversed())
        }
        selectedUserID = postData![indexPath.row].userID
        selectedPostBody = postData![indexPath.row].body
        selectedPostTitle = postData![indexPath.row].title
        selectedPostID = postData![indexPath.row].postID
        
        
        self.performSegue(withIdentifier: "segueToDetailPostVC", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailPostVC"{
            let vc = segue.destination as! DetailPostViewController
            vc.userName = selectedUserName!
            vc.userID = selectedUserID!
            vc.postTitle = selectedPostTitle!
            vc.postBody = selectedPostBody!
            vc.postID = selectedPostID!
        }
    }
    
}

