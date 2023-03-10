//
//  ImageDetailPresenter.swift
//  PixabayPhotoViewer-MVP+Router
//
//

import Foundation

protocol ImageDetailPresenterProtocol {
    var image: Image { get }
    func viewDidLoad()
}

final class ImageDetailPresenter: ImageDetailPresenterProtocol {
    private(set) var image: Image
    
    private weak var view: ImageDetailViewProtocol!
    private var model: ImageDetailModelProtocol
    
    init(image: Image, view: ImageDetailViewProtocol, model: ImageDetailModelProtocol) {
        self.image = image
        self.view = view
        self.model = model
    }
    
    func viewDidLoad() {
        model.fetchImage(url: image.webformatURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.view.updateView(userName: self!.image.user,
                                          datailImage: imageData,
                                          tags: self!.image.tags,
                                          views: self!.image.views,
                                          downloads: self!.image.downloads)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view.showError(title: "エラー",
                                         message: error.localizedDescription)
                }
            }
        }
    }
}
