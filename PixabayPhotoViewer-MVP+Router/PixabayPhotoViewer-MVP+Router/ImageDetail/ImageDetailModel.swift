//
//  ImageDetailModel.swift
//  PixabayPhotoViewer-MVP+Router
//
//

import Foundation

protocol ImageDetailModelProtocol {
    func fetchImage(url: URL, completion: @escaping (Result<Data, Error>) -> ())
}

final class ImageDetailModel: ImageDetailModelProtocol {
    private var task: URLSessionTask?
    
    func fetchImage(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        task = {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(imageData))
            }
            task.resume()
            return task
        }()
    }
}
