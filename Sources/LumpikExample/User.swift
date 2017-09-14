//
//  User.swift
//  LumpikExamplePackageDescription
//
//  Created by Satoshi Namai on 2017/09/10.
//

import Foundation
import Lumpik

struct User: Codable {
    let id: String
    let name: String
    let createdAt: Date
    let updatedAt: Date
}

final class UserRepository: Repository {
    let keyBase: String = "users"
    let pool: AnyConnectablePool<RedisStore>
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(pool: AnyConnectablePool<RedisStore>) {
        self.pool = pool
    }

    func fetchAll() throws -> [User]? {
        return try pool.with { store in
            let keys = try store.keys("\(keyBase)/*")
            let usersJSON = try store.mget(keys)
            
            return try usersJSON.filter { $0 != nil }.flatMap { userJSON in
                try decoder.decode(User.self, from: userJSON!.data(using: .utf8)!)
            }
        }
    }
    
    func fetch(by id: String) throws -> User? {
        return try pool.with { store in
            guard let userJSON = try store.get("\(keyBase)/\(id)") else { return nil }
            return try decoder.decode(User.self, from: userJSON.data(using: .utf8)!)
        }
    }
    
    func create(_ user: User) throws -> User? {
        return try pool.with { store in
            let userJSON = try encoder.encode(user).makeString()
            _ = try store.set("\(keyBase)/\(user.id)", value: userJSON)
            return user
        }
    }
    
    func update(_ user: User) throws -> User? {
        return try pool.with { store in
            let userJSON = try encoder.encode(user).makeString()
            _ = try store.set("\(keyBase)/\(user.id)", value: userJSON)
            return user
        }
    }
    
    func delete(by id: String) throws -> Bool {
        return try pool.with { store in
            _ = try store.delete("\(keyBase)/\(id)")
            return true
        }
    }
}
