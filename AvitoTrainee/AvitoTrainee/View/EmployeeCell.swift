//
//  EmployeeCell.swift
//  AvitoTrainee
//
//  Created by Никита Литвинов on 06.09.2021.
//

import Foundation
import UIKit

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
        nameLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        selectionStyle = .none
        [nameLabel, phone_numberLabel, firstSkillLabel, secondSkillLabel, thirdSkillLabel].forEach { contentView.addSubview($0) }
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
