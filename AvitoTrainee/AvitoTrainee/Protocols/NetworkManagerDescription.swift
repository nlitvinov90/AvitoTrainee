//
//  NetworkManagerDescription.swift
//  AvitoTrainee
//
//  Created by Никита Литвинов on 06.09.2021.
//
// Менеджера сразу закрываем протоколом, чтобы метод оставался тем же, если вдруг захотим
// поменять реализацию метода

import Foundation

protocol NetworkManagerDescription: AnyObject {
    func employees(completion: @escaping (Result<[Employee], Error>) -> Void)
}
