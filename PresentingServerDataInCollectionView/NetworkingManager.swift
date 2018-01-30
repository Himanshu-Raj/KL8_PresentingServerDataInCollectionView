//
//  NetworkingManager.swift
//  PresentingServerDataInCollectionView
//
//  Created by Chaudhary Himanshu Raj on 29/01/18.
//  Copyright © 2018 Chaudhary Himanshu Raj. All rights reserved.
//

import Foundation
import UIKit

class NetworkingManager {
    
    private init() {}
    static let shared = NetworkingManager()
    let session = URLSession.shared
    
    // MARK: Api call to make url request from imgur.
    func getImgurs(success successBlock : @escaping (Bool, GetImgurResponse?, Error?) -> Void) {
        guard let url = URL(string: "\(BASE_URL)\(USER_INPUTS)") else { return }
        var request = URLRequest(url: url)
        request.addValue("Client-ID eaccb630c8a976f", forHTTPHeaderField: "authorization")
        
        session.dataTask(with: request) { (data, response, error) in
            // Checking for Response.
            if let response = response {
               // print("RESPONSE : \(response)")
            }
            
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
    }   // getImgurs() - completed
    
    
    // MARK: Making api call to download images data from imgur website.
    // Note : URL provided here came as a response from previous function call.
    func downloadImage(at imageUrl : String, success successBlock : @escaping (Bool, UIImage?, Error?) -> Void) {
        guard let url = URL(string: imageUrl) else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            // Checking for Response.
            if let response = response {
                // print("RESPONSE : \(response)")
            }
            DispatchQueue.global().async {
                do {
                    let data = try Data (contentsOf : url)
                    guard let image = UIImage(data : data) else { return }
                        successBlock(true, image, nil)
                } catch {
                    print("Error Description : \(error)")
                    DispatchQueue.main.async {
                    successBlock(false, nil, error) }
                }
            }
        }.resume()
    } // DownloadingImage() - completed
    
}   // Class Ending
