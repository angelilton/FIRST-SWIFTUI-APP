//
//  WebService.swift
//  introducao
//
//  Created by mac on 23/01/2024.
//

import Foundation

enum WebService  {
    
    enum Method: String {
      case get
      case post
      case put
      case delete
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum EndPoint: String {
        case baseURL = "https://habitplus-api.tiagoaguiar.co"
        case userQuery = "/users"
        case login = "/auth/login"
        case habits = "/users/me/habits"
    }
    
    enum ContentType: String {
       case json = "application/json"
       case formUrl = "application/x-www-form-urlencoded"
     }
    
    public static func urlCreate(path: EndPoint) -> URLRequest? {
        guard let url = URL(string: "\(EndPoint.baseURL.rawValue)\(path.rawValue)") else {return nil}
        return URLRequest(url: url)
    }
    
    
    public static func call(method: Method = .post, body:Data?, query:EndPoint, contentType:ContentType, completion: @escaping (Result) -> Void ) {
        
        guard var urlRequest = urlCreate(path: query) else {return}
        
        //pegar o token da LocalDataSource
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                
            }
        
        //montando o url request
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = body // convert string to JSON
        
        //fazendo o request de fato com os dados de urlRequest
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else  {
                print(error as Any)
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let r = response as? HTTPURLResponse {
                switch r.statusCode {
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                case 401:
                    completion(.failure(.unauthorized, data))
                    break
                case 200:
                    completion(.success(data))
                    break
                default:
                    break
                }
            }
            
        }
        
        task.resume()
    }
    
    public static func call(
        query: EndPoint ,
        method: Method = .get,
        completion: @escaping (Result) -> Void
    ) {
        
        call(method: .get, body: nil, query: query, contentType: .json, completion:completion)
    }
    
}
