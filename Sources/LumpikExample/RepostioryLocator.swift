//
//  RepostioryLocator.swift
//  LumpikExamplePackageDescription
//
//  Created by Satoshi Namai on 2017/09/13.
//

import Foundation
import Lumpik

final class RepositoryLocator {
    var articleRepository: AnyRepository<Article> {
        return AnyRepository(_articleRepostiory)
    }
    private let _articleRepostiory: ArticleRepository
    
    var userRepository: AnyRepository<User> {
        return AnyRepository(_userRepostiory)
    }
    private let _userRepostiory: UserRepository
    
    private let pool: AnyConnectablePool<RedisStore>
    
    init(pool: AnyConnectablePool<RedisStore>) {
        self.pool = pool
        _articleRepostiory = ArticleRepository(pool: pool)
        _userRepostiory = UserRepository(pool: pool)
    }
}

protocol RepostioryInjectable {
    var repostioryLocator: RepositoryLocator { get }
}

extension RepostioryInjectable {
    var repostioryLocator: RepositoryLocator {
        #if TEST
            return RepositoryLocator(pool: AnyConnectablePool(ConnectionPool<RedisStore>(maxCapacity: 5)))
        #else
            return RepositoryLocator(pool: AnyConnectablePool(ConnectionPool<RedisStore>(maxCapacity: 5)))
        #endif
    }
}
