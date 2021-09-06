//
//  NetworkManagerDescription.swift
//  AvitoTrainee
//
//  Created by Никита Литвинов on 06.09.2021.
//

import Foundation

protocol NetworkManagerDescription: AnyObject {
    func employees(completion: @escaping (Result<[Employee], Error>) -> Void)
}
