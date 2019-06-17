//
//  DetailedBookView.swift
//  OpenLibrary
//
//  Created by Mac on 6/16/19.
//

import UIKit

class DetailedBookView: UIView {
    
    //MARK: - Subviews
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceHorizontal = false
        return sv
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let coverImage: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let isbnLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let wishListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to wishlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    // MARK: - Intialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupConstraints()
    }
    
    // MARK: - Helper Functions
    private func setupConstraints() {
        
        self.backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let screenWidth = UIScreen.main.bounds.width
        scrollView.addSubview(contentView)
        contentView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screenWidth, height: 0)
        
        
        contentView.addSubview(coverImage)
        coverImage.anchor(top: contentView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 300)
        coverImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: coverImage.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 48, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, width: 0, height: 0)
        
        contentView.addSubview(authorLabel)
        authorLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: titleLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        contentView.addSubview(isbnLabel)
        isbnLabel.anchor(top: authorLabel.bottomAnchor, left: authorLabel.leftAnchor, bottom: nil, right: authorLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        contentView.addSubview(publisherLabel)
        publisherLabel.anchor(top: isbnLabel.bottomAnchor, left: isbnLabel.leftAnchor, bottom: nil, right: isbnLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        contentView.addSubview(yearLabel)
        yearLabel.anchor(top: publisherLabel.bottomAnchor, left: publisherLabel.leftAnchor, bottom: nil, right: publisherLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        contentView.addSubview(languageLabel)
        languageLabel.anchor(top: yearLabel.bottomAnchor, left: publisherLabel.leftAnchor, bottom: nil, right: publisherLabel.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        contentView.addSubview(wishListButton)
        wishListButton.anchor(top: languageLabel.bottomAnchor, left: nil, bottom: contentView.bottomAnchor, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 48, paddingRight: 0, width: 200, height: 80)
        wishListButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        wishListButton.layer.cornerRadius = 3
    }
}
