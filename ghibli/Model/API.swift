//
//  API.swift
//  ghibli
//
//  Created by Arnold Sidiprasetija on 09/06/22.
//

import Foundation

struct APIManager {

    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return jsonDecoder
    }()
    
    func getMovies(successHandler: @escaping (StudioGhibliMovies) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: "https://ghibliapi.herokuapp.com/films")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print(error ?? "Error occurred")
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorHandler(NSError(domain: "", code: 0, userInfo: nil))
                }
                return
            }

            do {
                let movies = try APIManager.jsonDecoder.decode(StudioGhibliMovies.self, from: data)
                
                DispatchQueue.main.async {
                    successHandler(movies)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
