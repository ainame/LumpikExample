// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
import Lumpik

class Router: Routable {
    func dispatch(_ work: UnitOfWork, delegate: RouterDelegate) throws {
        switch work.workerType {
        case String(describing: SampleWorker.self):
            try invokeWorker(workerType: SampleWorker.self, work: work, delegate: delegate)
        default:
            throw RouterError.notFoundWorker
        }
    }
}

extension SampleWorker.Args {
    func toArray() -> [AnyArgumentValue] {
        return [
            message,
        ].map { AnyArgumentValue($0) }
    }

    static func from(_ array: [AnyArgumentValue]) -> SampleWorker.Args? {
        // NOTE: currently stencil template engine can not provide counter with starting 0
        guard let message = String(array[1 - 1].description)  else {
            return nil
        }

        return SampleWorker.Args(
            message: message
        )
    }
}
