//
//  Utils.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 21/5/23.
//

import Foundation

class Utils {
    
    static func parseJson<T: Decodable>(jsonName: String, model: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: jsonName, withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            
            let jsonDecoder = JSONDecoder()
            
            do {
                return try jsonDecoder.decode(T.self, from: data)
            } catch {
                print("JSON mock error: ", error)
                return nil
            }
        } catch {
            return nil
        }
    }
}
