import Foundation
import Lumpik

private let ENV = ProcessInfo.processInfo.environment
private var options = LaunchOptions()
private let host: String = ENV["REDIS_HOST"] ?? "localhost"
private let port: Int = Int(ENV["REDIS_PORT"] ?? "6379")!
options.redisConfig = RedisConfig(host: host, port: port)

private let router = Router()
options.router = router
let cli = CLI.makeCLI(options)
try ListRecipeWorker.performAsync(.init(keyword: "ラーメン", maxPage: 50), on: Queue("default"))
cli.start()
