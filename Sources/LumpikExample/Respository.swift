//
//  Respository.swift
//  LumpikExamplePackageDescription
//
//  Created by Satoshi Namai on 2017/09/12.
//

import Foundation

protocol Repository {
    associatedtype Item
    
    func fetchAll() throws -> [Item]?
    func fetch(by id: String) throws -> Item?
    func create(_: Item) throws -> Item?
    func update(_: Item) throws -> Item?
    func delete(by id: String) throws -> Bool
}

final class AnyRepository<T>: Repository {
    typealias Item = T
    
    private let _fetchAll: (() throws -> [Item]?)
    private let _fetch: ((String) throws -> Item?)
    private let _create: ((Item) throws -> Item?)
    private let _update: ((Item) throws -> Item?)
    private let _delete: (String) throws -> Bool

    init<R: Repository>(_ repository: R) where R.Item == T {
        _fetchAll = repository.fetchAll
        _fetch  = repository.fetch
        _create = repository.create
        _update = repository.update
        _delete = repository.delete
    }

    func fetchAll() throws -> [Item]? {
        return try _fetchAll()
    }
    
    func fetch(by id: String) throws -> Item? {
        return try _fetch(id)
    }
    
    func create(_ item: Item) throws -> Item? {
        return try _create(item)
    }

    func update(_ item: Item) throws -> Item? {
        return try _update(item)
    }
    
    func delete(by id: String) throws -> Bool {
        return try _delete(id)
    }
}
