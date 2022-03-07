//
//  Networking.swift
//  usersApp
//
//  Created by moshiko elkalay on 25/02/2022.
//

import Foundation
import Alamofire

struct Networking {
    
    enum NetworkError : Error{
        case network(error : Error)
        case serverRespone
        case unknown
    }
    
    
    private let baseUrl = "https://api.mockaroo.com/api/"
    private var apikey: String { "947b40d0" }
    
    
    func requestJson(count: Int = 120, completion : @escaping (Result<[User],NetworkError>) -> Void) {
        let request = AF.request(baseUrl + "729a5c80", parameters: ["count":"\(count)","key":apikey])
        request.responseJSON { (response) in
            guard let array = response.value as? [[String:Any]] else {
                if let error = response.error {
                    completion(.failure(.network(error: error)))
                } else {
                    completion(.failure(.unknown))
                }
                return
            }
            
            
            
        
            
            let users : [User] = array.compactMap{ User($0) }
            completion(.success(users))
        }
    }
    
    
}




