import Foundation
import Lumpik
import Kanna
import Dispatch
import Darwin

class ListWorker: BaseWorker, Worker {
    struct Args: Argument {
        let keyword: String
        let maxPage: Int
    }

    func perform(_ args: Args) throws {
        for page in 0...args.maxPage {
            let encodedKeyword: String = args.keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: "https://www.google.co.jp/search?q=\(encodedKeyword)&start=\(page*10)")!
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; NP06; rv:11.0) like Gecko"]

            let session = URLSession(configuration: configuration)
            let semaphore = DispatchSemaphore(value: 0)
            var htmlData: Data!
            let task = session.dataTask(with: url) { (data, response, error) in
                htmlData = data
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
            guard let html = HTML(html: htmlData, encoding: .utf8) else {
                print("failed access")
                return
            }
            
            for (_, element) in (html.css("h3.r a").enumerated()) {
                if let urlPath: String = element["href"] {
                    try SaveWorker.performAsync(.init(stringUrl: urlPath), on: Queue("default"))
                }
            }
        }
    }
}
