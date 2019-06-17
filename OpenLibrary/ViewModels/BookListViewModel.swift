//
//  BookListViewModel.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import Foundation

class BookListViewModel {
    
    // MARK: - Properties
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
    
    // MARK: - Intialization
    init() {
        
    }
}

// MARK: - Public Functions
extension BookListViewModel {
    
    
    func searchForBook(_ input : String) {
        
        APIClient.shared.searchForBook(input: input) { (books) in
           
            if let books = books {
                self.processBookResults(books: books)
            } else {
                // If no search results then clear UI
                let cellVM = [BookListCellViewModel]()
                self.cellViewModels = cellVM
            }
            
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
private extension BookListViewModel {
    
    private func processBookResults(books : [Book]) {
    
        self.books = books
        var cellVM = [BookListCellViewModel]()
        for book in books {
            cellVM.append(createCellViewModel(book: book))
        }
        self.cellViewModels = cellVM
    }
    
    private func createCellViewModel(book : Book) -> BookListCellViewModel {
        
        if let isbn = book.isbn {
            let coverImageURL = "http://covers.openlibrary.org/b/isbn/" + isbn + "-S.jpg"
            return BookListCellViewModel(titleText: book.title, authorText: book.author, imageURL: coverImageURL)
        } else {
            return BookListCellViewModel(titleText: book.title, authorText: book.author, imageURL: "")
        }
    }
}
