//
//  BookViewModel.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import UIKit
import RealmSwift

class BookViewModel {
    
    // MARK: - Properties
    private let realm = try! Realm()
    
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

    private var isOnWishList : Bool = false
    
    // MARK: Intialize - Dependency Injection
    init(book : Book) {
        self.book = book
        
        let wishListViewModel = WishListViewModel()
        isOnWishList = wishListViewModel.isBookOnWishList(book: book)
    }
}

// MARK: - public Functions
extension BookViewModel {
    
    // Create setters and getters because multiple ways to set isOnWishList
    func modifyisOnWishList() {
        
        isOnWishList = !isOnWishList
        isOnWishListChanged()
    }
    
    func getisOnWishList() -> Bool {
        
        return self.isOnWishList
    }
}

// MARK: - Helper Functions
private extension BookViewModel {
    
    func createAttributedText(label : String, bookInfo : String) -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString(string: label + ":  ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: bookInfo, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]))
        
        return attributedText
    }
    
    func isOnWishListChanged() {
        
        NotificationCenter.default.post(name: .didModifyWishList, object: nil)
        if isOnWishList {
            saveBook()
        } else {
            removeBook()
        }
    }
    
    func saveBook() {
        
        do {
            try realm.write {
                realm.add(book)
            }
        } catch {
            print("BookViewModel - Error saving book", error)
        }
        
    }
    
    func removeBook() {
        
    }
}
