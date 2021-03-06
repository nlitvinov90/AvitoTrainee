//
//  NetworkManager.swift
//  AvitoTrainee
//
//  Created by Никита Литвинов on 06.09.2021.
//
// Менеджер будет синглтоном

import Foundation


final class NetworkManager: NetworkManagerDescription{
    
    // приватный инициализатор, чтобы к мэнджеру обращались только через shared
    
    private init() {}
    
    
    
    static let shared: NetworkManagerDescription = NetworkManager()
    
    // @escaping чтобы передавать замыкание комплишн в другое замыкание
    
    func employees(completion: @escaping (Result<[Employee], Error>) -> Void) {
        
        guard  let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            completion(.failure(NetworkError.unexpected))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
           
            
            // замыкание, для вызова комплишна только в main потоке
            // один раз написать и вызывать лишь mainThreadCompletion

            let mainThreadCompletion: (Result<[Employee], Error>) -> Void =  { result in                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error = error {
                mainThreadCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                mainThreadCompletion(.failure(NetworkError.unexpected))
                return
            }
            
            do{
                let oneCompany = try JSONDecoder().decode(OneCompany.self, from: data)
                mainThreadCompletion(.success(oneCompany.company.employees))
            } catch let error{
                mainThreadCompletion(.failure(error))
            }
        }.resume()
        
    }
}
