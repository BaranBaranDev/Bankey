//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Baran Baran on 11.03.2024.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // Request Models
    private var profile: Profile?
    var accounts: [Account] = []

    // View Models
    var headerViewModel = AccountSummaryHeaderViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    
    
    private var accountsViewModel: [AccountSummaryViewModel] = []
    
    
    private var tableView = UITableView()
    private let headerView = AccountSummaryHeaderView()
    private lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Helpers

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        configureTableView()
        setupNavBar()
        fetchDataAndLoadViews()
    }
    
    private func setupNavBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
  
    
    private func setupTableView() {
   

        tableView.backgroundColor = appColor
        view.backgroundColor = appColor
        tableView.backgroundView?.backgroundColor = appColor
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
       
        
        view.addSubviews(tableView,headerView)
      
        // headerView layout
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
    
    
    private func configureTableView(){
        // TableView'ın arkasına bir arka plan görüntüsü ekleyelim
        let backgroundView = UIView()
        backgroundView.backgroundColor = appColor
        view.insertSubview(backgroundView, belowSubview: tableView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: tableView.topAnchor)
        ])
    }
}
// MARK: - UITableViewDataSource

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountsViewModel.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accountsViewModel[indexPath.row]
        cell.configure(with: account)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsViewModel.count
    }
}


// MARK: - UITableViewDelegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}




// MARK: - Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadViews() {

        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        fetchAccounts(forUserId: "1") { result in
                    switch result {
                    case .success(let accounts):
                        self.accounts = accounts
                        self.configureTableCells(with: accounts)
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
    }
    
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountsViewModel = accounts.map {
               AccountSummaryViewModel(accountType: $0.type,
                                            accountName: $0.name,
                                            balance: $0.amount)
           }
       }
    
}





// MARK: - Actions

extension AccountSummaryViewController {
    
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
       }
}




