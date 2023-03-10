//
//  ImageCell.swift
//  PixabayPhotoViewer-MVP+Router
//
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    private var task: URLSessionTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        photoImageView.image = nil
    }
    
    func configure(image: Image) {
        task = {
            let url = image.previewURL
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else {
                    return
                }
                
                DispatchQueue.global().async { [weak self] in
                    guard let image = UIImage(data: imageData) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.photoImageView?.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
            task.resume()
            return task
        }()
    }
}
