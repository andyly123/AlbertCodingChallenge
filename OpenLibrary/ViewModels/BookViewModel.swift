//
//  BookViewModel.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import UIKit

class BookViewModel {
    
    // MARK: - Properties
    private var wishListViewModel = WishListViewModel()
    
    private var book : Book
    
    var title: NSAttributedString {
        return createAttributedText(label: "Title", bookInfo: book.title)
    }
    
    var author: NSAttributedString {
        return createAttributedText(label: "Author", bookInfo: book.author)
    }
    
    var isbn: NSAttributedString {
        return createAttributedText(label: "ISBN", bookInfo: book.isbn)
    }
    
    var publisher: NSAttributedString {
        if let publisher = book.publisher {
            return createAttributedText(label: "Publisher", bookInfo: publisher)
        } else {
            return createAttributedText(label: "Publisher", bookInfo: "N/A")
        }
    }
    
    var publishYear: NSAttributedString {
        
        if let year = book.publishYear.value {
            return createAttributedText(label: "Year Published", bookInfo: String(year))
        } else {
            return createAttributedText(label: "Year Published", bookInfo: "N/A")
        }
    }
    
    var language: NSAttributedString {
        if let language = book.language {
            return createAttributedText(label: "Language", bookInfo: language)
        } else {
            return createAttributedText(label: "Language", bookInfo: "N/A")
        }
    }
    
    var imageURL: String {
        return "http://covers.openlibrary.org/b/isbn/" + book.isbn + "-L.jpg"
    }
    
    // MARK: Intialize - Dependency Injection
    init(book : Book) {
        self.book = book
    }
}

// MARK: - public Functions
extension BookViewModel {
    
    func bookWishModified() {

        wishListViewModel.modifyWishList(with: self.book)
    }
    
    func getisOnWishList() -> Bool {

        return wishListViewModel.isBookOnWishList(book)
    }
}

// MARK: - Helper Functions
private extension BookViewModel {
    
    func createAttributedText(label : String, bookInfo : String) -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString(string: label + ":  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: bookInfo, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        return attributedText
    }
}
