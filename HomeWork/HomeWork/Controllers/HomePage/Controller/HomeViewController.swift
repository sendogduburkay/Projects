//
//  ViewController.swift
//  HomeWork
//
//  Created by Muhammed Burkay Şendoğdu on 10.09.2022.
//

import UIKit


class HomeViewController: UIViewController {
    
    private var users: [User] = []
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUsers()
        setupTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
}

// MARK: - HomeViewController Helper
extension HomeViewController{
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    func setupUsers(){
        users.append(contentsOf: [
            .init(name: "Burkay", surname: "Şendoğdu", phoneNumber: "0511", gender: .Male),
            .init(name: "Gülten", surname: "Şendoğdu", phoneNumber: "0522", gender: .Female)
        ])
    }
}

// MARK: - HomeViewController Actions
extension HomeViewController{
    
    @objc func didTapAddButton(){
        guard let addUserViewController = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController
        else {
            print("wrong VC Identifier")
            return
        }
        addUserViewController.userStatus = .unregistered
        addUserViewController.delegate = self
        navigationController?.pushViewController(addUserViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { fatalError("Error for cell!")}
        cell.setupCell(user: users[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        guard let addViewController = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController else { return }
        addViewController.indexPath = indexPath
        addViewController.userStatus = .registered(user: user)
        addViewController.delegate = self
        navigationController?.pushViewController(addViewController, animated: true)
    }
}

// MARK: - AddViewControllerDelegate

extension HomeViewController: AddViewControllerDelegate{
    func didUserAddNewPerson(user: User) {
        users.append(user)
        tableView.reloadData()
    }
    
    func didUserUpdateInformation(user: User, indexPath: IndexPath?) {
        if let indexPath = indexPath {
            users[indexPath.row] = user
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
