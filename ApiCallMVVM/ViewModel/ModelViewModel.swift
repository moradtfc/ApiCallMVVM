//
//  ModelViewModel.swift
//  ApiCallMVVM
//
//  Created by Jesus Mora on 31/5/22.
//

import SwiftUI


class ModelViewModel: ObservableObject {
    
    @Published var movies: [Movie]?
    
    func fetchData(){
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=c94fe8ec569c8c127c750ab2cbb0773b&language=en-US&page=1")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do{
                    let discover = try JSONDecoder().decode(Discover.self, from: data)
                    DispatchQueue.main.async {
                        self.movies = discover.results
                    }
                } catch (let error){
                    print(error)
                    return
                }
            } else {
                print("error")
                return
            }
        }.resume()
        
    }
    
}
