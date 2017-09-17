import Foundation
import Lumpik
import Kanna

class SaveWorker: BaseWorker, Worker, RepostioryInjectable {
    struct Args: Argument {
        let stringUrl: String
    }

    lazy var articleRepository = repostioryLocator.articleRepository

    func perform(_ args: Args) throws {
        let url = URL(string: args.stringUrl)!
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
        guard htmlData != nil, let html = HTML(html: htmlData, encoding: .utf8) else {
            print("failed access")
            return
        }
        

        let title = html.title ?? ""
        let body = html.body?.text ?? ""
        let regex = try NSRegularExpression(pattern: "taylor", options: .caseInsensitive)
        let results = regex.matches(in: body, options: [], range: NSRange(0..<body.characters.count))
        
        let isTaylor = !results.isEmpty

        let article = Article(id: UUID().uuidString,
                              imageURL: url,
                              title: title,
                              body: isTaylor ? "E" : ".",
                              createdAt: Date())
        _ = try articleRepository.create(article)
        print(article)
    }
}
