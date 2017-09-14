import Foundation
import Lumpik

private let ENV = ProcessInfo.processInfo.environment
private var options = LaunchOptions()
private let host: String = ENV["REDIS_HOST"] ?? "localhost"
private let port: Int = Int(ENV["REDIS_PORT"] ?? "6379")!
options.redisConfig = RedisConfig(host: host, port: port)

private let connectionPoolForWorker = AnyConnectablePool(ConnectionPool<RedisStore>(maxCapacity: 3))
private let repostioryLocator = RepositoryLocator(pool: connectionPoolForWorker)

private let router = Router()
CLI.start(router: router, launchOptions: options)
