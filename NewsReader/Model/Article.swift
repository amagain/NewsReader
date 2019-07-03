//
//  Article.swift
//  NewsReader
//
//  Created by User on 28/6/19.
//  Copyright © 2019 amagain. All rights reserved.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}

extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string:
            "https://newsapi.org/v2/top-headlines?category=sports&language=en&apiKey=67a6f9415d1e49ad8dc91d85b3eb3d53")!
        return Resource(url: url)
        
    }()
}
