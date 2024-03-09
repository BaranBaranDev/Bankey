//
//  DummyViewController.swift
//  Bankey
//
//  Created by Baran Baran on 7.03.2024.
//

import UIKit

class DummyViewController: UIViewController {
    
    weak var delegate : DummyViewControllerDelegate?
    
    let stackView = UIStackView()
    let logOutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension DummyViewController {
    private func style() {
        view.backgroundColor = .systemBackground
        
        // stackview
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        // logoutButton
        logOutButton.setTitle(" Log Out ", for: .normal)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.configuration = .filled()
        logOutButton.configuration?.baseBackgroundColor = .systemBrown
        logOutButton.configuration?.imagePadding = 8
        logOutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        logOutButton.layer.cornerRadius = 15
        
    }
    
    private func layout() {
        
        stackView.addArrangedSubview(logOutButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
}


// MARK: - Actions
extension DummyViewController{
    @objc func logoutTapped(){
        delegate?.didlogOut()
    }
}
