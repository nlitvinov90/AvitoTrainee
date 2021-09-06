//
//  ViewController.swift
//  AvitoTrainee
//
//  Created by Никита Литвинов on 05.09.2021.
//

import UIKit


class ViewController: UIViewController{

    private let networkManager: NetworkManagerDescription = NetworkManager.shared
    private let tableView = UITableView()
    private let activityIndicatorView = UIActivityIndicatorView()
    private var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupActivityIndicator()
        loadEmployees()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.frame
        activityIndicatorView.frame = CGRect(x: 140, y: 140, width: 40, height: 40)
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
                self?.employees.append(employeess[2])
                self?.employees.append(employeess[5])
                self?.employees.append(employeess[1])
                self?.employees.append(employeess[0])
                self?.employees.append(employeess[3])
                self?.employees.append(employeess[6])
                self?.employees.append(employeess[4])
                for i in 1...6 where i != 5 {
                    self?.employees[i].skills.append("")
                }
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                print("Что то пошло не так, проверьте соединение с интернетом")
                // вставь сюда алерт
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell") as? EmployeeCell
        
        let employee = employees[indexPath.row]
        
        cell?.textLabel?.text = employee.name
        
        return cell ?? .init()
    }
}


final class EmployeeCell: UITableViewCell{
    
}
