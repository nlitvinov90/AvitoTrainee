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
    private var employees: [Employee] = []
    
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


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as? EmployeeCell else { return .init() }
        
        cell.configure(with: employees[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


final class EmployeeCell: UITableViewCell{
    
    private let nameLabel = UILabel()
    private let phone_numberLabel = UILabel()
    private let firstSkillLabel = UILabel()
    private let secondSkillLabel = UILabel()
    private let thirdSkillLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        
        [nameLabel, phone_numberLabel, firstSkillLabel, secondSkillLabel, thirdSkillLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.pin
            .top(8)
            .left(12)
            .height(60)
            .sizeToFit(.height)
        
        phone_numberLabel.pin
            .below(of: nameLabel)
            .left(12)
            .height(40)
            .sizeToFit(.height)
        
        firstSkillLabel.pin
            .top()
            .right(12)
            .height(40)
            .sizeToFit(.height)
        
        secondSkillLabel.pin
            .below(of: firstSkillLabel)
            .right(12)
            .height(40)
            .sizeToFit(.height)
        
        thirdSkillLabel.pin
            .below(of: secondSkillLabel)
            .right(12)
            .height(40)
            .sizeToFit(.height)
        
    }
    
    func configure(with model: Employee){
        nameLabel.text = model.name
        phone_numberLabel.text = "Phone: \(model.phone_number)"
        firstSkillLabel.text = model.skills[0]
        secondSkillLabel.text = model.skills[1]
        thirdSkillLabel.text = model.skills[2]
    }
    
}
