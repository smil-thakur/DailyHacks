//
//  NetworkManager.swift
//  DailyHacks
//
//  Created by Smil on 09/02/23.
//

import Foundation

class NetworkManager:ObservableObject{
    
    @Published var posts = [Hits]()
    
    func fetchData(){
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page"){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { Data, URLResponse, error in
                if let e = error {
                    print(e)
                }
                else{
                    let decoder = JSONDecoder()
                    if let safeData = Data{
                        do{
                            let results = try decoder.decode(Posts.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        }catch{
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}

//hits[0].title

struct Posts:Decodable{
    let hits:[Hits]
}

struct Hits:Decodable,Identifiable{
    var id:String{
        return objectID
    }
    let objectID:String
    let title:String
    let points:Int
    let url:String?
}
