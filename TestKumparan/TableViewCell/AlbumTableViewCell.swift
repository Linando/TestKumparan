//
//  AlbumTableViewCell.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import UIKit
import Alamofire
import AlamofireImage

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var photoTableView: UITableView!
    
    var albumID: Int?
    var photoData: [PhotoModel]?
    var leftPhotoID: Int?
    var middlePhotoID: Int?
    var rightPhotoID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoTableView.delegate = self
        photoTableView.dataSource = self
    }

    func getPhotoData(){
        AF.request("https://jsonplaceholder.typicode.com/albums/\(albumID!)/photos").responseData { [weak self] response in
            switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        self!.photoData = try JSONDecoder().decode([PhotoModel].self, from: data)
                        self!.photoTableView.reloadData()
                    } catch let error {
                        print(error)
                    }
                }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func leftPhotoTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let photoID: [String: Int] = ["ID": leftPhotoID!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "segueToPhotoDetailVC"), object: nil, userInfo: photoID)
    }
    
    @objc func middlePhotoTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let photoID: [String: Int] = ["ID": middlePhotoID!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "segueToPhotoDetailVC"), object: nil, userInfo: photoID)
    }
    
    @objc func rightPhotoTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let photoID: [String: Int] = ["ID": rightPhotoID!]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "segueToPhotoDetailVC"), object: nil, userInfo: photoID)
    }
}

extension AlbumTableViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if photoData == nil{
            return 0
        }else if photoData!.count % 3 == 0{
            return photoData!.count/3
        }else{
            return photoData!.count/3+1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = photoTableView.dequeueReusableCell(withIdentifier: "PhotoCell") as? PhotoTableViewCell{
            
            var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftPhotoTapped(tapGestureRecognizer:)))
            
            cell.leftPhoto.af.setImage(withURL: URL(string: photoData![indexPath.row*3].thumbnailURL)!)
            leftPhotoID = photoData![indexPath.row*3].id
            cell.leftPhoto.isUserInteractionEnabled = true
            cell.leftPhoto.addGestureRecognizer(tapGestureRecognizer)
            
            
            if indexPath.row*3+1 <= photoData!.count-1{
                if let middlePhoto = photoData?[indexPath.row*3+1].thumbnailURL{
                    cell.middlePhoto.af.setImage(withURL: URL(string: middlePhoto)!)
                    middlePhotoID = photoData![indexPath.row*3+1].id
                    cell.middlePhoto.isUserInteractionEnabled = true
                    tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(middlePhotoTapped(tapGestureRecognizer:)))
                    cell.middlePhoto.addGestureRecognizer(tapGestureRecognizer)
                }
            }
            
            if indexPath.row*3+2 <= photoData!.count-1{
                if let rightPhoto = photoData?[indexPath.row*3+2].thumbnailURL{
                    cell.rightPhoto.af.setImage(withURL: URL(string: rightPhoto)!)
                    rightPhotoID = photoData![indexPath.row*3+2].id
                    cell.rightPhoto.isUserInteractionEnabled = true
                    tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightPhotoTapped(tapGestureRecognizer:)))
                    cell.rightPhoto.addGestureRecognizer(tapGestureRecognizer)
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
