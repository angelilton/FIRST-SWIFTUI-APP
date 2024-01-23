//
//  WebService.swift
//  introducao
//
//  Created by mac on 23/01/2024.
//

import Foundation

struct UserProps {
    let fullName: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
}


enum WebService  {
    
    enum EndPoint: String {
        case baseURL = "https://habitplus-api.tiagoaguiar.co"
        case userQuery = "/users"
    }
    
    private static func urlCreate(path: EndPoint) -> URLRequest? {
        guard let url = URL(string: "\(EndPoint.baseURL.rawValue)\(path.rawValue)") else {return nil}
        return URLRequest(url: url)
    }
    
    
    
    static func postUser(user: UserProps) {
        
        let json: [String : Any] = [
          "name": user.fullName,
          "email": user.email,
          "document": user.document,
          "phone": user.phone,
          "gender": user.gender,
          "birthday": user.birthday,
          "password": user.password
        ]
         
        guard var urlRequest = urlCreate(path: .userQuery) else {return}
        
        //montando o url request
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: json) // convert string to JSON
        
        //fazendo o request de fato com os dados de urlRequest
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else  {
                print(error)
                return
            }
            print("return data\n")
            print(String(data: data, encoding: .utf8))
            print("response\n")
                  
            print(response)
            
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
        }
            task.resume()
        
    }
}
