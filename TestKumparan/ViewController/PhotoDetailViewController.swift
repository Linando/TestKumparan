//
//  PhotoDetailViewController.swift
//  TestKumparan
//
//  Created by Linando Saputra on 06/09/21.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoScrollView: UIScrollView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    var photoID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoScrollView.delegate = self
        photoScrollView.minimumZoomScale = 1.0
        photoScrollView.maximumZoomScale = 6.0
        
        AF.request("https://jsonplaceholder.typicode.com/photos/\(photoID!)").responseData { [weak self] response in
            switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    do {
                        let photoData = try JSONDecoder().decode(PhotoModel.self, from: data)
                        self!.photoTitleLabel.text = photoData.title
                        self!.photoImage.af.setImage(withURL: URL(string: photoData.url)!)
                        
                    } catch let error {
                        print(error)
                    }
                }
        }
    }
    
}

extension PhotoDetailViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
           
        return photoImage
    }
}
