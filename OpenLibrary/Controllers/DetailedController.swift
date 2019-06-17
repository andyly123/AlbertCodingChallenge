//
//  DetailedController.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import UIKit

class DetailedController: UIViewController {
    
    // MARK: - Properties
    var detailedBookView = DetailedBookView()
    private var viewModel : BookViewModel
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = detailedBookView
        setupNavBar()
        setupView()
    }
    
    // MARK: - Intializaer
    init(book : Book) {
        self.viewModel = BookViewModel(book: book)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailedController {
    
    func setupNavBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
    }
    
    @objc func handleBack() {
        
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        
        //detailedBookView.scrollView.delegate = self
        detailedBookView.coverImage.loadImage(urlString: viewModel.imageURL)
        detailedBookView.titleLabel.attributedText = viewModel.title
        detailedBookView.authorLabel.attributedText = viewModel.author
        detailedBookView.isbnLabel.attributedText = viewModel.isbn
        detailedBookView.publisherLabel.attributedText = viewModel.publisher
        detailedBookView.yearLabel.attributedText = viewModel.publishYear
        detailedBookView.languageLabel.attributedText = viewModel.language
    }
}

//extension DetailedController: UIScrollViewDelegate {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.x>0 {
//            scrollView.contentOffset.x = 0
//        }
//    }
//}
