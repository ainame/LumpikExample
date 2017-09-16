//
//  RepostioryLocator.swift
//  LumpikExamplePackageDescription
//
//  Created by Satoshi Namai on 2017/09/13.
//

import Foundation
import Lumpik

final class RepositoryLocator {
    static let shared = RepositoryLocator(pool: AnyConnectablePool(ConnectionPool<RedisStore>(maxCapacity: 5)))
    
    var articleRepository: AnyRepository<Article> {
        return AnyRepository(_articleRepostiory)
    }
    private let _articleRepostiory: ArticleRepository
    
    private let pool: AnyConnectablePool<RedisStore>
    
    init(pool: AnyConnectablePool<RedisStore>) {
        self.pool = pool
        _articleRepostiory = ArticleRepository(pool: pool)
    }
}

protocol RepostioryInjectable {
    var repostioryLocator: RepositoryLocator { get }
}

extension RepostioryInjectable {
    var repostioryLocator: RepositoryLocator {
        #if TEST
            return RepositoryLocator.shared
        #else
            return RepositoryLocator(pool: AnyConnectablePool(ConnectionPool<RedisStore>(maxCapacity: 5)))
        #endif
    }
}
