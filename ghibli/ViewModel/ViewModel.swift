//
//  MovieTableCell.swift
//  ghibli
//
//  Created by Arnold Sidiprasetija on 09/06/22.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    private var apiManager: APIManager?
    @Published var movies: [StudioGhibliMovie] = []

    init() {
        self.apiManager = APIManager()
    }

    func fetchMovies() {
        apiManager?.getMovies(successHandler: { [weak self] (movies) in
            self?.movies = movies
        }) { (error) in
            print("Error occurred: ", error)
        }
    }

}
