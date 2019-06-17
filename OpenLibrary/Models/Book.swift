//
//  Book.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import Foundation
import RealmSwift

class Book: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var isbn : String = ""
    @objc dynamic var publisher : String? = nil
    var publishYear = RealmOptional<Int>()
    @objc dynamic var language : String? = nil
}
