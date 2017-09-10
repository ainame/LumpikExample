import Foundation
import Lumpik

let ENV = ProcessInfo.processInfo.environment
var options = LaunchOptions()
let host: String = ENV["REDIS_HOST"]!
let port: Int = Int(ENV["REDIS_PORT"]!)!
options.redisConfig = RedisConfig(host: host, port: port)

let router = Router()
CLI.start(router: router, launchOptions: options)
