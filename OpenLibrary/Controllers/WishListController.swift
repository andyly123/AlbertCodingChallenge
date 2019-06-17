//
//  WishListController.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import UIKit

class WishListController: UITableViewController {
    
    // MARK: - Property
    private let cellId = "cellId"
    
    private lazy var viewModel: WishListViewModel = {
        return WishListViewModel()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadWishList()
    }
}

// MARL: - Helper Functions
private extension WishListController {
    
    func setupNavBar() {
        
        navigationItem.title = "Wish List"
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
    }
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func setupViewModel() {
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableViewDataSource
extension WishListController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BookTableViewCell
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        
        cell.titleLabel.text = cellVM.titleText
        cell.authorLabel.text = cellVM.authorText
        if let imageURL = cellVM.imageURL {
            cell.coverImage.loadImage(urlString: imageURL)
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

// Mark: - TableViewDelegate
extension WishListController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let book = viewModel.getBook(at: indexPath)
        let detailedController = DetailedController(book: book)
        self.navigationController?.pushViewController(detailedController, animated: true)
    }
}
