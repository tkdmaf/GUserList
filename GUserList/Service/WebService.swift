//
//  WebService.swift
//  GUserList
//
//  Created by 蕭文安 on 2020/3/11.
//  Copyright © 2020 蕭文安. All rights reserved.
//

import Foundation
import Moya

let moyaProvider = MoyaProvider<WebService>(plugins: [NetworkLoggerPlugin(verbose:true)])

enum WebService {
    
    case listUser
    
    case users(since:Int, per_page: Int)
    
    case user(login: String)
    
}

extension WebService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
            
        case .listUser:
            return "/users"
            
        case .users:
            return "/users"
            
        case .user(let login):
            return "/users/\(login)"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        default:
               return .get
        }
        
       
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .listUser:
            return .requestPlain
        case .users(let since,let per_page):
            
            return .requestParameters(parameters: ["since":since,"per_page":per_page], encoding: URLEncoding.default)
            
        case .user:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
   
}
