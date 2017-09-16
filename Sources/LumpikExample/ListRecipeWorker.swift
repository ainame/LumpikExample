import Foundation
import Lumpik
import Kanna

class ListRecipeWorker: BaseWorker, Worker {
    struct Args: Argument {
        let keyword: String
        let maxPage: Int
    }
    
    func perform(_ args: Args) throws {
        for page in 0...args.maxPage {
            let encodedKeyword: String = args.keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: "https://cookpad.com/search/\(encodedKeyword)?page=\(page)")!
            let html = HTML(url: url, encoding: .utf8)
            
            for (_, element) in (html?.css("a.recipe-title").enumerated())! {
                if let urlPath: String = element["href"] {
                    try SaveRecipeWorker.performAsync(.init(path: urlPath), on: Queue("default"))
                }
            }
            
            sleep(1)
        }
    }
}
