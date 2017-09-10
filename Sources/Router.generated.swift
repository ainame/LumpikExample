// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Lumpik

class Router: Routable {
    func dispatch(_ work: UnitOfWork, delegate: RouterDelegate) throws {
        switch work.workerType {
        case String(describing: PostRandomArticleWorker.self):
            try invokeWorker(workerType: PostRandomArticleWorker.self, work: work, delegate: delegate)
        default:
            throw RouterError.notFoundWorker
        }
    }
}

extension PostRandomArticleWorker.Arg {
    func toArray() -> [AnyArgumentValue] {
        return [
            title,
        ].map { AnyArgumentValue($0) }
    }

    static func from(_ array: [AnyArgumentValue]) -> PostRandomArticleWorker.Arg? {
        // NOTE: currently stencil template engine can not provide counter with starting 0
        let title = array[1 - 1].stringValue

        return PostRandomArticleWorker.Arg(
            title: title
        )
    }
}
