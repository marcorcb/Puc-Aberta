//
//  LoginService.swift
//  Puc Aberta
//
//  Created by Marco Braga on 19/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

class LoginService: APIRequest {
    @discardableResult
    static func login(cpf: String, birthdate: Date, completion: ResponseBlock<User>?) -> LoginService {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let queryParams = ["cpf": cpf, "nasc": dateFormatter.string(from: birthdate)]
        let request = LoginService(method: .get, path: "inscrito", parameters: nil, urlParameters: queryParams, cacheOption: .networkOnly) { (response, error, cache) in
            if let response = response as? JSONDictionary, let subscription = response["inscrito"] as? JSONDictionary, error == nil {
                if subscription["nasc"] == nil || subscription["nasc"] is NSNull  {
                    completion?(nil, nil, cache)
                } else {
                    let user = User(dictionary: response)
                    completion?(user, nil, cache)
                }
            } else {
                completion?(nil, error, cache)
            }
        }
        request.shouldSaveInCache = false
        request.makeRequest()
        
        return request
    }
    
    @discardableResult
    static func login(cpf: String, birthdate: String, completion: ResponseBlock<User>?) -> LoginService {
        let request = LoginService(method: .get, path: "inscrito", parameters: nil, urlParameters: ["cpf": cpf, "nasc": birthdate], cacheOption: .networkOnly) { (response, error, cache) in
            if let response = response as? JSONDictionary, let subscription = response["inscrito"] as? JSONDictionary, error == nil {
                if subscription["nasc"] == nil || subscription["nasc"] is NSNull  {
                    completion?(nil, nil, cache)
                } else {
                    let user = User(dictionary: response)
                    completion?(user, nil, cache)
                }
            } else {
                completion?(nil, error, cache)
            }
        }
        request.shouldSaveInCache = false
        request.makeRequest()
        
        return request
    }
}
