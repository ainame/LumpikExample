import Foundation
import Lumpik
import Kanna

class SaveRecipeWorker: BaseWorker, Worker, RepostioryInjectable {
    struct Args: Argument {
        let path: String
    }
    
    lazy var articleRepository = repostioryLocator.articleRepository
    
    func perform(_ args: Args) throws {
        let url = URL(string: "https://cookpad.com\(args.path)")!
        guard let html = HTML(url: url, encoding: .utf8) else { return }
        
        let title = html.css("h1.recipe-title").first?.text ?? ""
        let imageURL = URL(string: html.css("img.photo").first?["src"] ?? "https://example.com/image")!
        let article = Article(id: UUID().uuidString,
                              imageURL: imageURL,
                              title: title,
                              body: "",
                              createdAt: Date())
        _ = try articleRepository.create(article)
        print(article)
    }
}

