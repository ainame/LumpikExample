import Foundation
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

let ENV = ProcessInfo.processInfo.environment
var options = LaunchOptions()
let host: String = ENV["REDIS_HOST"]!
let port: Int = Int(ENV["REDIS_PORT"]!)!
options.redisConfig = RedisConfig(host: host, port: port)

let router = Router()
CLI.start(router: router, launchOptions: options)
