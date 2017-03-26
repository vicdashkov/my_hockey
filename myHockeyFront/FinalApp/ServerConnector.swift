//
//  File.swift
//  FinalApp
//
//  Created by viktor dashkov on 2016-06-10.
//  Copyright © 2016 viktor dashkov. All rights reserved.
//

import Foundation

class ServerConnector {

    
    // functionToPass parameter will be called once data is retrieved from the server.
    // This retrieved data will be passed to functionToPass as regular string.
    // What "passed" function does with the string is up to function
    static func dataRequest(_ serverFile: String, postMessage: String = "", functionToPass: @escaping (_ string: String) -> Void)  {
        
        let url:URL = URL(string: "http://www.studycontrol.org/ios/\(serverFile).php")!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "data=\(postMessage)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            
            functionToPass(dataString as String)
            
        }) 
        
        task.resume()
        
    }
    
 

    
    // This method fetches games from server and them as string
//    static func fetchGamesFromServer() -> [Game] {
//        let game1 = Game(team1: "vancouver", team2: "toronto")
//        let game2 = Game(team1: "kelowna", team2: "victoria")
//        let game3 = Game(team1: "richmond", team2: "burnaby")        
//        
//        return[game1, game2, game3]
//    }
}
