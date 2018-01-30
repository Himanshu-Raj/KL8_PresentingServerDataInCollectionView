//
//  NetworkingManager.swift
//  PresentingServerDataInCollectionView
//
//  Created by Chaudhary Himanshu Raj on 29/01/18.
//  Copyright © 2018 Chaudhary Himanshu Raj. All rights reserved.
//

import Foundation

class NetworkingManager {
    
    private init() {}
    static let shared = NetworkingManager()
    let session = URLSession.shared
    
    func getImgurs(success successBlock : @escaping (Bool, GetImgurResponse?, Error? ) -> Void) {
        guard let url = URL(string: "\(BASE_URL)\(USER_INPUTS)") else { return }
        var request = URLRequest(url: url)
        request.addValue("Client-ID eaccb630c8a976f", forHTTPHeaderField: "authorization")
        
        session.dataTask(with: request) { (data, response, error) in
                    guard let data = data else { return }
                do  {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else { return }
                    
                    // Creating getImgurResponse object and printing response.
                        let getImgurResponse = try GetImgurResponse(json: json)
                        DispatchQueue.main.async {
                            successBlock(true, getImgurResponse, nil) }
                } catch {
                    print("JSON Error Description : \(error)")
                        DispatchQueue.main.async {
                            successBlock(false, nil, error) }
                }
        }.resume() // session.dataTask ending.
    }   // func getImgurs() ending
}   // Class Ending
