//
//  ViewController.swift
//  AvitoTrainee
//
//  Created by Никита Литвинов on 05.09.2021.
//

import UIKit
import PinLayout

class ViewController: UIViewController{

    private let networkManager: NetworkManagerDescription = NetworkManager.shared
    private let tableView = UITableView()
    private let activityIndicatorView = UIActivityIndicatorView()
    internal var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Avito"
        
        setupTableView()
        setupActivityIndicator()
        loadEmployees()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
        activityIndicatorView.pin
            .center()
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicatorView)
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "EmployeeCell")
        
        view.addSubview(tableView)
    }
    
    private func loadEmployees() {
        activityIndicatorView.startAnimating()
        networkManager.employees {[weak self] (result) in
            self?.activityIndicatorView.stopAnimating()
            
            switch result {
            case .success(let employeess):
                
                // расставление имен в алфавитном порядке
                
                self?.employees.append(employeess[2])
                self?.employees.append(employeess[5])
                self?.employees.append(employeess[1])
                self?.employees.append(employeess[0])
                self?.employees.append(employeess[3])
                self?.employees.append(employeess[6])
                self?.employees.append(employeess[4])
                
                // добавляю еще один пустой скилл для людей, у которых всего 2 скилла
                // чтобы не было index out of range при обращении
                
                for i in 1...6 where i != 5 {
                    self?.employees[i].skills.append("")
                }
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                self?.showAlert(message: "Что-то пошло не так, проверьте соединение с интернетом")
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
