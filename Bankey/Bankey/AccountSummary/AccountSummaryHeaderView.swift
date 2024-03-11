//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Baran Baran on 11.03.2024.
//


import UIKit

class AccountSummaryHeaderView: UIView {
    
    // MARK: - Properties
    
    private let bankeyLabel = UILabel()
    private let messageLabel = UILabel()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    
}

// MARK: - Helpers

extension AccountSummaryHeaderView {
    private func style() {
        backgroundColor = appColor
        translatesAutoresizingMaskIntoConstraints = false
       
        // bankeyLabel
        bankeyLabel.text = "Bankey"
        bankeyLabel.textColor = .black
        bankeyLabel.font = .preferredFont(forTextStyle: .largeTitle)
        bankeyLabel.numberOfLines = 0
        
        // messageLabel
        messageLabel.text = "Good Morning"
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        
        // nameLabel
        nameLabel.text = "Baran"
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        
        
        // dateLabel
        dateLabel.text = "Date"
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 0
        
        
       
        
        
        
        
    }
    
    private func layout() {
        addSubviews(stackView,imageView)
        stackView.addArrangedSubviews(bankeyLabel,messageLabel,nameLabel,dateLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
        ])
        
        stackView.heightAnchor.constraint(equalToConstant: 144).isActive = true
        
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1),
            imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 75),
            imageView.widthAnchor.constraint(equalToConstant: 75)
        ])
        
      
    }
}






