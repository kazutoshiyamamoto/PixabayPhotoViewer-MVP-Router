//
//  SearchImageRouter.swift
//  PixabayPhotoViewer-MVP+Router
//
//

import UIKit

protocol SearchImageRouterProtocol: AnyObject {
    func transitionToImageDetail(image: Image)
}

class SearchImageRouter: SearchImageRouterProtocol {
    private(set) weak var view: SearchImageViewProtocol!

    init(view: SearchImageViewProtocol) {
        self.view = view
    }

    func transitionToImageDetail(image: Image) {
        let imageDetailVC = UIStoryboard(name: "ImageDetail",
                                         bundle: nil)
            .instantiateInitialViewController() as! ImageDetailViewController
        let model = ImageDetailModel()
        let presenter = ImageDetailPresenter(image: image,
                                             view: imageDetailVC,
                                             model: model)
        imageDetailVC.inject(presenter: presenter)
        
        view.pushViewController(imageDetailVC, animated: true)
    }
}
