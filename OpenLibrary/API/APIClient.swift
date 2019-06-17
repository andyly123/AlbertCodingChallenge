//
//  APIClient.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import Foundation
import RealmSwift

// MARK: - Structs for JSONecoder
struct Response: Decodable {
    let start: Int
    let num_found: Int
    let docs : [Doc]
}

struct Doc: Decodable {
    let title : String?
    let author_name : [String]?
    let isbn : [String]?
    let publisher : [String]?
    let first_publish_year : Int?
    let language : [String]?
}

// MARK: - API Class
class APIClient:NSObject {
    
    // MARK: - Properties
    static let shared = APIClient()
    
    // MARK: - Intialization
    private override init() { }
    
    // MARK: - API Call Functions
    func searchForBook(input : String, completion: @escaping (_ books : [Book]?) -> ()){
        
        // Replace all spaces with + so that its in the api's format
        let formattedInput = input.replacingOccurrences(of: " ", with: "+")
        let urlString = "http://openlibrary.org/search.json?title=" + formattedInput
        
        // Encode the "+" characters so that string can be formatter into url
        guard let jsonURLString = urlString.addingPercentEncoding(withAllowedCharacters:.rfc3986Unreserved) else { return }
        guard let url = URL(string: jsonURLString) else { return }
        
        // Make call request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                // Get first 10 books
                var booksArray = [Book]()
                var counter = 0
                for doc in response.docs {
                    if counter > 10 {
                        break
                    }
                    // Only retrieving books that have a title, author, and isbn
                    if let title = doc.title {
                        if let author = doc.author_name?[0] {
                            if let isbn = doc.isbn?[0] {
                                let book = Book()
                                book.title = title
                                book.author = author
                                book.isbn = isbn
                                book.publisher = doc.publisher?[0]
                                book.publishYear = RealmOptional<Int>(doc.first_publish_year)
                                book.language = doc.language?[0]
                                
                                booksArray.append(book)
                                counter += 1
                            }
                        }
                    }
                }
                completion(booksArray)
                
            } catch let jsonError {
                print("APICLIENT - Error serializing json:", jsonError)
                // Call completion block with no results found (nil)
                completion(nil)
            }
        }.resume()
    }
}
