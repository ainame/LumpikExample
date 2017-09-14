//
//  Article.swift
//  LumpikExamplePackageDescription
//
//  Created by Satoshi Namai on 2017/09/10.
//

import Foundation
import Lumpik

struct Article: Codable {
   let id: Int
   let title: String
   let body: String
   let createdAt: Date
   let updatedAt: Date
   let publishedAt: Date
}

final class ArticleRepository: Repository {
    let keyBase: String = "articles"
    let pool: AnyConnectablePool<RedisStore>
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(pool: AnyConnectablePool<RedisStore>) {
        self.pool = pool    
    }
    
    func fetchAll() throws -> [Article]? {
        return try pool.with { store in
            let keys = try store.keys("\(keyBase)/*")
            let articlesJSON = try store.mget(keys)
            
            return try articlesJSON.filter { $0 != nil }.flatMap { articleJSON in
                try decoder.decode(Article.self, from: articleJSON!.data(using: .utf8)!)
            }
        }
    }
    
    func fetch(by id: String) throws -> Article? {
        return try pool.with { store in
            guard let articleJSON = try store.get("\(keyBase)/\(id)") else { return nil }
            return try decoder.decode(Article.self, from: articleJSON.data(using: .utf8)!)
        }
    }
    
    func create(_ article: Article) throws -> Article? {
        return try pool.with { store in
            let articleJSON = try encoder.encode(article).makeString()
            _ = try store.set("\(keyBase)/\(article.id)", value: articleJSON)
            return article
        }
    }
    
    func update(_ article: Article) throws -> Article? {
        return try pool.with { store in
            let articleJSON = try encoder.encode(article).makeString()
            _ = try store.set("\(keyBase)/\(article.id)", value: articleJSON)
            return article
        }
    }
    
    func delete(by id: String) throws -> Bool {
        return try pool.with { store in
            _ = try store.delete("\(keyBase)/\(id)")
            return true
        }
    }
}
