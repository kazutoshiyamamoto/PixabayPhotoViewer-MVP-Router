//
//  SearchImagePresenter.swift
//  PixabayPhotoViewer-MVP+Router
//
//

import Foundation

protocol SearchImagePresenterProtocol {
    var query: String? { get }
    var pagination: Pagination? { get }
    var isFetching: Bool { get }
    var numberOfImages: Int { get }
    func image(forItem item: Int) -> Image?
    func didSelectItem(at indexPath: IndexPath)
    func searchImages(query: String?, page: Int)
    func clearImages()
}

final class SearchImagePresenter: SearchImagePresenterProtocol {
    private(set) var query: String?
    private(set) var pagination: Pagination?
    private(set) var isFetching = false
    
    private(set) var images: [Image] = []
    
    private weak var view: SearchImageViewProtocol!
    private var model: SearchImageModelProtocol
    private let router: SearchImageRouterProtocol
    
    init(view: SearchImageViewProtocol,
         model: SearchImageModelProtocol,
         router: SearchImageRouterProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    var numberOfImages: Int {
        return images.count
    }
    
    func image(forItem item: Int) -> Image? {
        guard item < images.count else { return nil }
        return images[item]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let image = image(forItem: indexPath.row) else { return }
        router.transitionToImageDetail(image: image)
    }
    
    func searchImages(query: String?, page: Int) {
        guard let query = query else { return }
        guard !query.isEmpty else { return }
        
        self.isFetching = true
        
        model.fetchImage(query: query, page: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.images.append(contentsOf: response.0)
                self?.query = query
                self?.pagination = response.1
                
                DispatchQueue.main.async {
                    self?.view.reloadCollectionView()
                    self?.isFetching = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isFetching = false
                    self?.view.showError(title: "エラー",
                                         message: error.localizedDescription)
                }
            }
        }
    }
    
    func clearImages() {
        self.images = []
    }
}
