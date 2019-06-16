//
//  SearchController.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import UIKit

class SearchController: UITableViewController {
    
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private let cellId = "cellId"
    private var searchTimer: Timer?
    
    lazy var viewModel: BookListViewModel = {
        return BookListViewModel()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        setupViewModel()
    }
}

// MARK: - Helper Functions
private extension SearchController {
    
    func setupNavBar() {
        
        navigationItem.title = "Book Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Book Title"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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

// MARK: - UISearchResultsUpdating Delegate
extension SearchController: UISearchResultsUpdating {
    
    // Send API call everytime user changes search string
    func updateSearchResults(for searchController: UISearchController) {
        
        // Use timer so only make API call after user finishes typing
        // If a timer is already active, prevent it from firing
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        
        // Reschedule the search: in 1.0 second, call the searchForKeyword method on the new textfield content
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword(_:)), userInfo: searchController.searchBar.text!, repeats: false)
    }
    
    @objc func searchForKeyword(_ timer: Timer) {
        
        // retrieve the keyword from user info
        guard let keyword = timer.userInfo as? String else { return }
        self.viewModel.searchForBook(keyword)
    }
}

// MARK: - TableViewDataSource
extension SearchController {
    
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
extension SearchController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
