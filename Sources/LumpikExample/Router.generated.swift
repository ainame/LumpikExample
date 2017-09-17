// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Lumpik

class Router: Routable {
    func dispatch(_ work: UnitOfWork, delegate: RouterDelegate) throws {
        switch work.workerType {
        case String(describing: ListWorker.self):
            try invokeWorker(workerType: ListWorker.self, work: work, delegate: delegate)
        case String(describing: SaveWorker.self):
            try invokeWorker(workerType: SaveWorker.self, work: work, delegate: delegate)
        default:
            throw RouterError.notFoundWorker
        }
    }
}

extension ListWorker.Args {
    func toArray() -> [AnyArgumentValue] {
        return [
            keyword,
            maxPage,
        ].map { AnyArgumentValue($0) }
    }

    static func from(_ array: [AnyArgumentValue]) -> ListWorker.Args? {
        // NOTE: currently stencil template engine can not provide counter with starting 0
        let keyword = array[1 - 1].stringValue
        let maxPage = array[2 - 1].intValue

        return ListWorker.Args(
            keyword: keyword,
            maxPage: maxPage
        )
    }
}

extension SaveWorker.Args {
    func toArray() -> [AnyArgumentValue] {
        return [
            stringUrl,
        ].map { AnyArgumentValue($0) }
    }

    static func from(_ array: [AnyArgumentValue]) -> SaveWorker.Args? {
        // NOTE: currently stencil template engine can not provide counter with starting 0
        let stringUrl = array[1 - 1].stringValue

        return SaveWorker.Args(
            stringUrl: stringUrl
        )
    }
}
