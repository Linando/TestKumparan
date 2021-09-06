//
//  UserDetailViewController.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import UIKit
import Alamofire



class UserDetailViewController: UIViewController {
    
    

    @IBOutlet weak var userCompanyLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var albumTableView: UITableView!
    
    var albumData: [AlbumModel]?
    var userID: Int?
    var photoID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        albumTableView.delegate = self
        albumTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(segueToPhotoDetailVC), name: NSNotification.Name(rawValue: "segueToPhotoDetailVC"), object: nil)
        
        AF.request("https://jsonplaceholder.typicode.com/users/\(userID!)").responseData { [weak self] response in
            switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let userData = try JSONDecoder().decode(UserModel.self, from: data)
                        self!.userNameLabel.text = userData.name
                        self!.userAddressLabel.text = "\(userData.address.street), \(userData.address.suite), \(userData.address.city)"
                        self!.userEmailLabel.text = userData.email
                        self!.userCompanyLabel.text = userData.company.name
                    } catch let error {
                        print(error)
                    }
                }
        }
        
        AF.request("https://jsonplaceholder.typicode.com/users/\(userID!)/albums").responseData { [weak self] response in
            switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        self!.albumData = try JSONDecoder().decode([AlbumModel].self, from: data)
                        self!.albumTableView.reloadData()
                    } catch let error {
                        print(error)
                    }
                }
        }
        
    }
    
    @objc func segueToPhotoDetailVC(_ notification: NSNotification){
        
        if let photoID = notification.userInfo?["ID"] as? Int{
            self.photoID = photoID
        }
        performSegue(withIdentifier: "segueToPhotoDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPhotoDetailVC"{
            let vc = segue.destination as! PhotoDetailViewController
            vc.photoID = photoID
        }
    }
}

extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if albumData == nil{
            return 0
        }else{
            return albumData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = albumTableView.dequeueReusableCell(withIdentifier: "AlbumCell") as? AlbumTableViewCell{
            cell.albumNameLabel.text = albumData![indexPath.row].title
            cell.albumID = albumData![indexPath.row].id
            cell.getPhotoData()
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    
}
