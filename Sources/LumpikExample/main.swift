import Lumpik

class Base {
    var jid: Jid?
    var queue: Queue?
    var retry: Int?

    required init() {}
}

class SampleWorker: Base, Worker {
    struct Args: Argument {
        let message: String
    }

    func perform(_ args: Args) {
        print("Hello \(args.message)!")
    }
}

let router = Router()
CLI.start(router: router)
