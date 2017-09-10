//
//  PostRandomArticleWorker.swift
//  LumpikExamplePackageDescription
//
//  Created by Satoshi Namai on 2017/09/10.
//

import Foundation
import Lumpik

class PostRandomArticleWorker: BaseWorker, Worker {
    struct Args: Argument {
        let title: String
    }

    func perform(_ args: Args) throws {
        print(args)
    }
}
