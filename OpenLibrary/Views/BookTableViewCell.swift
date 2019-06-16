//
//  BookTableViewCell.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    let coverImage: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - Intialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(coverImage)
        coverImage.anchor(top: self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 24, width: 60, height: 80)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: coverImage.leftAnchor, paddingTop: 15, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 0)
        
        addSubview(authorLabel)
        authorLabel.anchor(top: titleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: coverImage.leftAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
