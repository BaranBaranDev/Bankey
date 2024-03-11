//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Baran Baran on 11.03.2024.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    // MARK: - Properties
    
    var accounts: [AccountSummaryViewModel] = []
    
    private var tableView = UITableView()
    
    private let headerView = AccountSummaryHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Helpers

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        view.addSubviews(tableView,headerView)
        
        // headerView layout
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
        ])
       
        
        // tableView layout
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: headerView.bottomAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDataSource

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}


// MARK: - UITableViewDelegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


// MARK: - fetchData

// MARK: - fetchData
extension AccountSummaryViewController {
    private func fetchData() {
        
        
        let savings = AccountSummaryViewModel(accountType: .Banking,
                                              accountName: "Basic Savings",
                                              balance: 929466.23)
        let chequing = AccountSummaryViewModel(accountType: .Banking,
                                               accountName: "No-Fee All-In Chequing",
                                               balance: 17562.44)
        let visa = AccountSummaryViewModel(accountType: .CreditCard,
                                           accountName: "Visa Avion Card",
                                           balance: 412.83)
        let masterCard = AccountSummaryViewModel(accountType: .CreditCard,
                                                 accountName: "Student Mastercard",
                                                 balance: 50.83)
        let investment1 = AccountSummaryViewModel(accountType: .Investment,
                                                  accountName: "Tax-Free Saver",
                                                  balance: 2000.00)
        let investment2  = AccountSummaryViewModel(accountType: .Investment,
                                                   accountName: "Growth Fund",
                                                   balance: 15000.00)

        
        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}
