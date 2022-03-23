//  Coder.swift
//  movielist
//
//  Created by Mostafa on 6/15/20.
//  Copyright © 2020 nura abd al majeed. All rights reserved.
//

import Foundation


class Coder {
    private var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    
    init(decodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys){
        keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func decode<T: Codable>(toType myType: T.Type, from jsonData: Data) -> T?{
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = self.keyDecodingStrategy
            
            let decodedData: T = try decoder.decode(myType, from: jsonData)
            return decodedData
        }
        catch let error{
            print("json decode error", error)
        }
        return nil
    }
    
    func encode<T: Codable>(fromCodable codable: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(codable)
            return encodedData
        }
        catch let error {
            print("json encode error", error)
        }
        return nil
    }
    
    func encodeToSring<T: Codable>(fromCodable codable: T) -> String? {
        let data: Data = self.encode(fromCodable: codable) ?? Data()
        let json = String(data: data, encoding: String.Encoding.utf8)
        
        return json
    }
}


extension String {
    func dictionary() -> [String: Any]?
    {
        if let data = self.data(using: .utf8)
        {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            }
            catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
