// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Lumpik

class Router: Routable {
    func dispatch(_ work: UnitOfWork, delegate: RouterDelegate) throws {
        switch work.workerType {
        case String(describing: ListRecipeWorker.self):
            try invokeWorker(workerType: ListRecipeWorker.self, work: work, delegate: delegate)
        case String(describing: SaveRecipeWorker.self):
            try invokeWorker(workerType: SaveRecipeWorker.self, work: work, delegate: delegate)
        default:
            throw RouterError.notFoundWorker
        }
    }
}

extension ListRecipeWorker.Args {
    func toArray() -> [AnyArgumentValue] {
        return [
            keyword,
            maxPage,
        ].map { AnyArgumentValue($0) }
    }

    static func from(_ array: [AnyArgumentValue]) -> ListRecipeWorker.Args? {
        // NOTE: currently stencil template engine can not provide counter with starting 0
        let keyword = array[1 - 1].stringValue
        let maxPage = array[2 - 1].intValue

        return ListRecipeWorker.Args(
            keyword: keyword,
            maxPage: maxPage
        )
    }
}

extension SaveRecipeWorker.Args {
    func toArray() -> [AnyArgumentValue] {
        return [
            path,
        ].map { AnyArgumentValue($0) }
    }

    static func from(_ array: [AnyArgumentValue]) -> SaveRecipeWorker.Args? {
        // NOTE: currently stencil template engine can not provide counter with starting 0
        let path = array[1 - 1].stringValue

        return SaveRecipeWorker.Args(
            path: path
        )
    }
}
