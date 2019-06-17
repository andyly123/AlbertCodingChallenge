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
        setupButton()
        setupObserver()
    }
    
    // MARK: - Intializaer
    init(book : Book) {
        self.viewModel = BookViewModel(book: book)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Helper Functions
private extension DetailedController {
    
    func setupNavBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
    }
    
    @objc func handleBack() {
        
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        
        detailedBookView.coverImage.loadImage(urlString: viewModel.imageURL)
        detailedBookView.titleLabel.attributedText = viewModel.title
        detailedBookView.authorLabel.attributedText = viewModel.author
        detailedBookView.isbnLabel.attributedText = viewModel.isbn
        detailedBookView.publisherLabel.attributedText = viewModel.publisher
        detailedBookView.yearLabel.attributedText = viewModel.publishYear
        detailedBookView.languageLabel.attributedText = viewModel.language
        
        if viewModel.getisOnWishList() {
            setRemoveButton()
        }
    }
    
    func setupButton() {
        
        detailedBookView.wishListButton.addTarget(self, action: #selector(handlePressed), for: .touchUpInside)
    }
    
    @objc func handlePressed() {
        
        viewModel.modifyisOnWishList()
    }
    
    func setupObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(onWishListChanged), name: .didModifyWishList, object: nil)
    }
    
    // Change button when user adds/remove book from wish list
    @objc func onWishListChanged(_ notification:Notification) {
    
        if viewModel.getisOnWishList() {
            setRemoveButton()
        } else {
            setAddButton()
        }
    }
    
    func setAddButton() {
        
        self.detailedBookView.wishListButton.setTitle("Add to wishlist", for: .normal)
        self.detailedBookView.wishListButton.backgroundColor = .blue
    }
    
    func setRemoveButton() {
        
        self.detailedBookView.wishListButton.setTitle("Remove from wishlist", for: .normal)
        self.detailedBookView.wishListButton.backgroundColor = .red
    }
}
