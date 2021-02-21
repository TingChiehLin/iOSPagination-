//
//  FetchDataManager.swift
//  iOS-Pagination
//
//  Created by Lin Ting Chieh on 2021/2/15.
//

import Foundation
 
protocol DataManagerDelegate {
    func didUpdatePhoto(photo: [Photo])
    func didFailWithError(error: Error)
}

struct FetchDataManager {
    let fetchURL = "https://picsum.photos/v2/list"
    var delegate: DataManagerDelegate?
    
    func fetchData(_ pageNumber: Int){
        let urlString = "\(fetchURL)?page=\(pageNumber)&limit=60"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
       
                if let safeData = data {
                    if let photoData = self.parseJSON(safeData) {
                      DispatchQueue.main.async {
                            self.delegate?.didUpdatePhoto(photo:photoData)
                      }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [Photo]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([Photo].self, from: data)
//            print("decodeData:\(decodeData)")
            return decodeData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
