//
//  WishListViewModel.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import Foundation
import RealmSwift

class WishListViewModel {
    
    // MARK: - Properties
    private let realm = try! Realm()
    
    private var results: Results<Book>?
    private var books = [Book]()
    
    var reloadTableViewClosure: (()->())?
    private var cellViewModels = [BookListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count 
    }
    
    // MARK: - Intailization
    init() {
        loadWishList()
    }
}

// MARK: - Public Function
extension WishListViewModel {
    
    // Get all books on wish list stored in database
    func loadWishList() {
        
        results = realm.objects(Book.self)
        
        if let results = results {
            self.processBookResults(results: results)
        } else {
            // If no search results then clear UI
            let cellVM = [BookListCellViewModel]()
            self.cellViewModels = cellVM
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> BookListCellViewModel {
        
        return cellViewModels[indexPath.row]
    }
    
    func getBook(at indexPath: IndexPath) -> Book {
        
        return books[indexPath.row]
    }
}

// MARK: - Helper Functions
private extension WishListViewModel {
    
    // Create cellViewModel and books array from results array
    private func processBookResults(results : Results<Book>) {
        
        books.removeAll()
        var cellVM = [BookListCellViewModel]()
        for result in results {
            let book = Book()
            book.title = result.title
            book.author = result.author
            book.isbn = result.isbn
            book.publisher = result.publisher
            book.publishYear = result.publishYear
            book.language = result.language
            cellVM.append(createCellViewModel(book: book))
            books.append(book)
        }
        self.cellViewModels = cellVM
    }
    
    private func createCellViewModel(book : Book) -> BookListCellViewModel {
        
        let coverImageURL = "http://covers.openlibrary.org/b/isbn/" + book.isbn + "-S.jpg"
        return BookListCellViewModel(titleText: book.title, authorText: book.author, imageURL: coverImageURL)
    }
}

