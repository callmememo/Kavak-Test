//
//  RestAPI.swift
//  Kavak Test
//
//  Created by Memo on 4/13/21.
//

import Foundation
import Alamofire

class RestAPI {
    
    class func fetchGnomes(_ completion: @escaping (Result<[Gnome], Error>) -> Void) {
        AF.request("https://raw.githubusercontent.com/rrafols/mobile_test/master/data.json").responseJSON { response in
            
            guard let data = response.data else {
                completion(.failure(response.error ?? NSError(domain:"", code: 500, userInfo:nil)))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let brastlewark = try decoder.decode(Brastlewark.self, from: data)
                completion(.success(brastlewark.brastlewark))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
