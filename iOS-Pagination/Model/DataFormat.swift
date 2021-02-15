//
//  DataFormat.swift
//  iOS-Pagination
//
//  Created by Lin Ting Chieh on 2021/2/15.
//

import Foundation

struct DataFormat:Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
    
    //fail
    //let photos: [Photo]
}

//fail
struct Photo: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}

