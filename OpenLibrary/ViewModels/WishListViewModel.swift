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
        
        return results?[indexPath.row] ?? Book()
    }
    
    func isBookOnWishList(_ book : Book) -> Bool {
        
        guard let books = results else { return false }
        for item in books {
            if book.isbn == item.isbn {
                if !book.isDeleted {
                    return true
                }
                return false
            }
        }
        return false
    }
    
    func isBookInDatabase(_ book : Book) -> Bool {
        
        guard let books = results else { return false }
        for item in books {
            if book.isbn == item.isbn {
                return true
            }
        }
        return false
    }
    
    func modifyWishList(with book : Book) {
        
        NotificationCenter.default.post(name: .didModifyWishList, object: nil)
        if isBookOnWishList(book) {
            removeBook(book)
        } else {
            saveBook(book)
        }
    }
    
    func saveBook(_ book : Book) {
        
        do {
            try realm.write {
                // If book is on wish list then just change isDeleted property, else add to wishlist
                if isBookInDatabase(book) {
                    book.isDeleted = !book.isDeleted
                } else {
                    realm.add(book)
                }
                loadWishList()
            }
        } catch {
            print("BookViewModel - Error saving book", error)
        }
    }
    
    func removeBook(_ book : Book) {
        
        do {
            try realm.write {
                // Instead of deleting object just change isDeleted Property so realm doesnt crash
                book.isDeleted = !book.isDeleted
                loadWishList()
            }
        } catch {
            print("BookViewModel - Error saving book", error)
        }
    }
}

// MARK: - Helper Functions
private extension WishListViewModel {
    
    // Create cellViewModel and books array from results array
    private func processBookResults(results : Results<Book>) {
        
        var cellVM = [BookListCellViewModel]()
        for result in results {
            if !result.isDeleted {
                let book = Book()
                book.title = result.title
                book.author = result.author
                book.isbn = result.isbn
                book.publisher = result.publisher
                book.publishYear = result.publishYear
                book.language = result.language
                cellVM.append(createCellViewModel(book: book))
            }
        }
        self.cellViewModels = cellVM
    }
    
    private func createCellViewModel(book : Book) -> BookListCellViewModel {
        
        let coverImageURL = "http://covers.openlibrary.org/b/isbn/" + book.isbn + "-S.jpg"
        return BookListCellViewModel(titleText: book.title, authorText: book.author, imageURL: coverImageURL)
    }
}

