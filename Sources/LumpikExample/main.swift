import Foundation
import Lumpik

let ENV = ProcessInfo.processInfo.environment

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

var options = LaunchOptions()
options.redisConfig = RedisConfig(host: ENV["REDIS_HOST"]!, port: ENV["REDIS_PORT"]!)

let router = Router()
CLI.start(router: router, launchOptions: options)
